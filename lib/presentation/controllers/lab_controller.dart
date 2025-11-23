// presentation/controllers/lab_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/data/models/lab_model.dart';
import 'package:healthy_heart_junior/data/repositories/medical_repository.dart';

class LabController extends GetxController {
  static LabController get instance => Get.find();

  // قيم الإدخال (كلها Double عشان ما نلخبط بين Int/Double)
  final RxDouble heartRate   = 72.0.obs;   // نبضة/دقيقة
  final RxDouble systolicBP  = 120.0.obs;  // الضغط الانقباضي
  final RxDouble diastolicBP = 80.0.obs;   // الضغط الانبساطي
  final RxDouble bloodSugar  = 90.0.obs;   // السكر
  final RxDouble ckMb        = 5.0.obs;    // CK-MB
  final RxDouble troponin    = 0.01.obs;   // Troponin

  // حالة التحليل + السجل
  final RxBool isAnalyzing = false.obs;
  final RxList<LabModel> labHistory = <LabModel>[].obs;
  final Rx<LabModel?> lastAnalysis = Rx<LabModel?>(null);

  final medicalRepository = MedicalRepository.instance;

  /// تحديث قيمة RxDouble من نص
  void updateValue(RxDouble target, String text) {
    final cleaned = text.replaceAll(',', '.');
    final v = double.tryParse(cleaned);
    if (v != null) {
      target.value = v;
    }
  }

  Future<void> analyzeLabResults() async {
    isAnalyzing.value = true;

    try {
      // محاكاة زمن تحليل الذكاء الاصطناعي
      await Future.delayed(const Duration(seconds: 2));

      bool isAtRisk = false;
      String diagnosis = 'طبيعي';
      double confidence = 0.85;

      if (heartRate.value > 100 || heartRate.value < 60)        isAtRisk = true;
      if (systolicBP.value > 140 || diastolicBP.value > 90)     isAtRisk = true;
      if (bloodSugar.value > 126)                               isAtRisk = true;
      if (ckMb.value > 25)                                      isAtRisk = true;
      if (troponin.value > 0.1)                                 isAtRisk = true;

      if (isAtRisk) {
        diagnosis  = 'خطر محتمل';
        confidence = 0.75;
      }

      // تكوين LabModel باستخدام نفس المودل الذي عندك
      final labAnalysis = LabModel(
        heartRate:   heartRate.value.toInt(),
        systolicBP:  systolicBP.value.toInt(),
        diastolicBP: diastolicBP.value.toInt(),
        bloodSugar:  bloodSugar.value,
        ckMb:        ckMb.value,
        troponin:    troponin.value,
        result:      isAtRisk ? 'risk' : 'normal',
        confidence:  confidence,
        date:        DateTime.now(),
      );

      // حفظ في الريبو (نفس الأسامي اللي كنت تستعملها)
      await medicalRepository.saveLabAnalysis(labAnalysis);

      // تحديث السجل في الواجهة
      labHistory.insert(0, labAnalysis);
      lastAnalysis.value = labAnalysis;

      // عرض نتيجة التحليل في Dialog
      Get.defaultDialog(
        title: 'نتيجة التحليل المخبري',
        titleStyle: TextStyle(
          color: isAtRisk ? AppColors.warning : AppColors.success,
          fontWeight: FontWeight.bold,
        ),
        content: Column(
          children: [
            Icon(
              isAtRisk ? Icons.warning_amber : Icons.verified,
              color: isAtRisk ? AppColors.warning : AppColors.success,
              size: 50,
            ),
            const SizedBox(height: 16),
            Text(
              diagnosis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isAtRisk ? AppColors.warning : AppColors.success,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'دقة التشخيص: ${(confidence * 100).toStringAsFixed(1)}%',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            if (isAtRisk) ...[
              const SizedBox(height: 8),
              Text(
                'نوصي بمراجعة الطبيب لإجراء فحوصات إضافية',
                style: TextStyle(color: AppColors.warning),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isAtRisk ? AppColors.warning : AppColors.success,
          ),
          child: const Text(
            'حسناً',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        'خطأ في التحليل',
        'فشل في تحليل النتائج',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    } finally {
      isAnalyzing.value = false;
    }
  }

  void resetForm() {
    heartRate.value   = 72.0;
    systolicBP.value  = 120.0;
    diastolicBP.value = 80.0;
    bloodSugar.value  = 90.0;
    ckMb.value        = 5.0;
    troponin.value    = 0.01;
  }

  Future<void> loadLabHistory() async {
    try {
      final history = await medicalRepository.getLabHistory();
      labHistory.assignAll(history);
      if (history.isNotEmpty) {
        lastAnalysis.value = history.first;
      }
    } catch (e) {
      print('Error loading lab history: $e');
    }
  }
}
