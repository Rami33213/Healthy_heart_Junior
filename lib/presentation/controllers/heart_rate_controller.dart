// presentation/controllers/heart_rate_controller.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/data/models/heart_rate_model.dart';
import 'package:healthy_heart_junior/data/repositories/medical_repository.dart';
import 'package:healthy_heart_junior/data/services/rppg_service.dart';

class HeartRateController extends GetxController {
  static HeartRateController get instance => Get.find();
  
  final RxList<HeartRateModel> heartRateHistory = <HeartRateModel>[].obs;
  final Rx<HeartRateModel?> lastMeasurement = Rx<HeartRateModel?>(null);
  final RxBool isMeasuring = false.obs;
  final RxDouble progress = 0.0.obs;
  final RxString status = 'جاهز للقياس'.obs;
  
  final medicalRepository = MedicalRepository.instance;
  final rppgService = RPPGService();
  
  Future<void> startCameraMeasurement() async {
    isMeasuring.value = true;
    progress.value = 0.0;
    status.value = 'جاري التحضير...';
    
    try {
      // محاكاة عملية القياس
      for (int i = 0; i < 100; i += 10) {
        await Future.delayed(const Duration(milliseconds: 300));
        progress.value = i / 100;
        
        if (i < 30) {
          status.value = 'جاري اكتشاف الوجه...';
        } else if (i < 70) {
          status.value = 'جاري تحليل الإشارة...';
        } else {
          status.value = 'جاري حساب النبض...';
        }
      }
      
      // نتيجة عشوائية للمحاكاة (في الواقع ستأتي من الـ RPPG)
      final random = Random();
      final heartRate = 60 + random.nextInt(40); // بين 60 و 100
      final confidence = 0.7 + random.nextDouble() * 0.3; // بين 0.7 و 1.0
      
      final measurement = HeartRateModel(
        heartRate: heartRate,
        date: DateTime.now(),
        method: 'camera',
        confidence: confidence,
      );
      
      await medicalRepository.saveHeartRate(measurement);
      lastMeasurement.value = measurement;
      heartRateHistory.insert(0, measurement);
      
      Get.snackbar(
        'نجاح القياس',
        'معدل ضربات القلب: $heartRate نبضة/دقيقة',
        backgroundColor: _getHeartRateColor(heartRate),
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'خطأ في القياس',
        'فشل في عملية القياس، حاول مرة أخرى',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    } finally {
      isMeasuring.value = false;
      progress.value = 0.0;
      status.value = 'جاهز للقياس';
    }
  }
  
  Color _getHeartRateColor(int heartRate) {
    if (heartRate < 60) return AppColors.warning;
    if (heartRate > 100) return AppColors.danger;
    return AppColors.success;
  }
  
  Future<void> loadHeartRateHistory() async {
    try {
      final history = await medicalRepository.getHeartRateHistory();
      heartRateHistory.assignAll(history);
      if (history.isNotEmpty) {
        lastMeasurement.value = history.first;
      }
    } catch (e) {
      print('Error loading heart rate history: $e');
    }
  }
}