// data/services/ecg_analysis_service.dart
import 'dart:math';

import 'package:healthy_heart_junior/data/models/ecg_model.dart';

class ECGAnalysisService {
  Future<EcgModel> analyzeECG(String ecgData) async {
    // محاكاة خدمة تحليل ECG الحقيقية
    await Future.delayed(const Duration(seconds: 4));
    
    final random = Random();
    final isNormal = random.nextDouble() > 0.3;
    final confidence = 0.8 + random.nextDouble() * 0.2;
    
    return EcgModel(
      ecgData: ecgData,
      result: isNormal ? 'normal' : 'abnormal',
      confidence: confidence,
      date: DateTime.now(),
      notes: isNormal ? 'تخطيط قلب طبيعي' : 'يوجد اضطراب في تخطيط القلب',
    );
  }
}