// presentation/controllers/ecg_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../data/models/ecg_model.dart';
import '../../data/repositories/medical_repository.dart';
import '../../data/services/ecg_analysis_service.dart';

class EcgController extends GetxController {
  static EcgController get instance => Get.find();
  
  final RxList<EcgModel> ecgHistory = <EcgModel>[].obs;
  final RxBool isAnalyzing = false.obs;
  final RxDouble analysisProgress = 0.0.obs;
  final RxString analysisStatus = 'جاهز للتحليل'.obs;
  
  final medicalRepository = MedicalRepository.instance;
  final ecgService = ECGAnalysisService();
  
  Future<void> analyzeECG(String ecgFilePath) async {
    isAnalyzing.value = true;
    analysisProgress.value = 0.0;
    analysisStatus.value = 'جاري تحميل الملف...';
    
    try {
      // محاكاة عملية التحليل
      final steps = ['جاري معالجة الإشارة...', 'جاري إزالة الضوضاء...', 'جاري تحليل النمط...', 'جاري التشخيص...'];
      
      for (int i = 0; i < steps.length; i++) {
        analysisStatus.value = steps[i];
        analysisProgress.value = (i + 1) / steps.length;
        await Future.delayed(const Duration(seconds: 1));
      }
      
      // نتائج عشوائية للمحاكاة
      final random = Random();
      final isNormal = random.nextDouble() > 0.3; // 70% normal
      final confidence = 0.8 + random.nextDouble() * 0.2; // بين 0.8 و 1.0
      
      final result = EcgModel(
        ecgData: ecgFilePath,
        result: isNormal ? 'normal' : 'abnormal',
        confidence: confidence,
        date: DateTime.now(),
        notes: isNormal ? 'تخطيط قلب طبيعي' : 'يوجد اضطراب في تخطيط القلب، يرجى مراجعة الطبيب',
      );
      
      await medicalRepository.saveECG(result);
      ecgHistory.insert(0, result);
      
      Get.defaultDialog(
        title: 'نتيجة تحليل ECG',
        titleStyle: TextStyle(
          color: isNormal ? const Color(0xFF2ED573) : const Color(0xFFFF4757), 
          fontWeight: FontWeight.bold
        ),
        content: Column(
          children: [
            Icon(
              isNormal ? Icons.check_circle : Icons.warning,
              color: isNormal ? const Color(0xFF2ED573) : const Color(0xFFFF4757),
              size: 50,
            ),
            const SizedBox(height: 16),
            Text(
              isNormal ? 'طبيعي' : 'غير طبيعي',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isNormal ? const Color(0xFF2ED573) : const Color(0xFFFF4757),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'دقة التشخيص: ${(confidence * 100).toStringAsFixed(1)}%',
              style: const TextStyle(color: Color(0xFF718096)),
            ),
            if (!isNormal) ...[
              const SizedBox(height: 8),
              const Text(
                'نوصي بمراجعة طبيب القلب',
                style: TextStyle(color: Color(0xFFFF4757)),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: isNormal ? const Color(0xFF2ED573) : const Color(0xFFFF4757),
          ),
          child: const Text('حسناً', style: TextStyle(color: Colors.white)),
        ),
      );
      
    } catch (e) {
      Get.snackbar(
        'خطأ في التحليل',
        'فشل في تحليل ملف ECG',
        backgroundColor: const Color(0xFFFF4757),
        colorText: Colors.white,
      );
    } finally {
      isAnalyzing.value = false;
      analysisProgress.value = 0.0;
      analysisStatus.value = 'جاهز للتحليل';
    }
  }
  
  Future<void> loadECGHistory() async {
    try {
      final history = await medicalRepository.getECGHistory();
      ecgHistory.assignAll(history);
    } catch (e) {
      print('Error loading ECG history: $e');
    }
  }
}