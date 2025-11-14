// data/services/rppg_service.dart
import 'dart:math';

import 'package:healthy_heart_junior/data/models/heart_rate_model.dart';

class RPPGService {
  Future<HeartRateModel> analyzeVideo(String videoPath) async {
    // محاكاة خدمة RPPG الحقيقية
    await Future.delayed(const Duration(seconds: 3));
    
    final random = Random();
    final heartRate = 60 + random.nextInt(40);
    final confidence = 0.7 + random.nextDouble() * 0.3;
    
    return HeartRateModel(
      heartRate: heartRate,
      date: DateTime.now(),
      method: 'upload',
      confidence: confidence,
    );
  }
}