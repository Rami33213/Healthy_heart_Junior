// presentation/controllers/lab_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/theme/app_theme.dart';
import 'package:healthy_heart_junior/data/models/lab_model.dart';
import 'package:healthy_heart_junior/data/repositories/medical_repository.dart';

class LabController extends GetxController {
  static LabController get instance => Get.find();
  
  final RxList<LabModel> labHistory = <LabModel>[].obs;
  final Rx<LabModel?> lastAnalysis = Rx<LabModel?>(null);
  final RxBool isAnalyzing = false.obs;
  
  final medicalRepository = MedicalRepository.instance;
  
  final RxInt heartRate = 72.obs;
  final RxInt systolicBP = 120.obs;
  final RxInt diastolicBP = 80.obs;
  final RxDouble bloodSugar = 90.0.obs;
  final RxDouble ckMb = 5.0.obs;
  final RxDouble troponin = 0.01.obs;
  
  Future<void> analyzeLabResults() async {
    isAnalyzing.value = true;
    
    try {
      await Future.delayed(const Duration(seconds: 2)); // محاكاة تحليل الذكاء الاصطناعي
      
      // تحليل بسيط للمحاكاة
      bool isAtRisk = false;
      String diagnosis = 'طبيعي';
      double confidence = 0.85;
      
      if (heartRate.value > 100 || heartRate.value < 60) isAtRisk = true;
      if (systolicBP.value > 140 || diastolicBP.value > 90) isAtRisk = true;
      if (bloodSugar.value > 126) isAtRisk = true;
      if (ckMb.value > 25) isAtRisk = true;
      if (troponin.value > 0.1) isAtRisk = true;
      
      if (isAtRisk) {
        diagnosis = 'خطر محتمل';
        confidence = 0.75;
      }
      
      final labAnalysis = LabModel(
        heartRate: heartRate.value,
        systolicBP: systolicBP.value,
        diastolicBP: diastolicBP.value,
        bloodSugar: bloodSugar.value,
        ckMb: ckMb.value,
        troponin: troponin.value,
        result: isAtRisk ? 'risk' : 'normal',
        confidence: confidence,
        date: DateTime.now(),
      );
      
      await medicalRepository.saveLabAnalysis(labAnalysis);
      labHistory.insert(0, labAnalysis);
      lastAnalysis.value = labAnalysis;
      
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
            SizedBox(height: 16),
            Text(
              diagnosis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isAtRisk ? AppColors.warning : AppColors.success,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'دقة التشخيص: ${(confidence * 100).toStringAsFixed(1)}%',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            if (isAtRisk) ...[
              SizedBox(height: 8),
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
            backgroundColor: isAtRisk ? AppColors.warning : AppColors.success,
          ),
          child: Text('حسناً', style: TextStyle(color: Colors.white)),
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
    heartRate.value = 72;
    systolicBP.value = 120;
    diastolicBP.value = 80;
    bloodSugar.value = 90.0;
    ckMb.value = 5.0;
    troponin.value = 0.01;
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