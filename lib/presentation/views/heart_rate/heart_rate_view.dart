// presentation/views/heart_rate/heart_rate_view.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/core/theme/app_theme.dart';
import 'package:healthy_heart_junior/data/models/heart_rate_model.dart';
import 'package:healthy_heart_junior/presentation/controllers/heart_rate_controller.dart';

class HeartRateView extends GetView<HeartRateController> {
  const HeartRateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildMeasurementSection(),
              const SizedBox(height: 24),
              _buildHistorySection(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        const SizedBox(width: 8),
        Text(
          'قياس ضربات القلب',
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildMeasurementSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.favorite, color: Colors.white, size: 50),
          const SizedBox(height: 16),
          Text(
            'قياس معدل ضربات القلب',
            style: AppStyles.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'استخدم الكاميرا لقياس نبضك في 30 ثانية',
            style: AppStyles.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          Obx(() {
            if (controller.isMeasuring.value) {
              return _buildMeasuringProgress();
            } else {
              return _buildMeasurementButtons();
            }
          }),
        ],
      ),
    );
  }
  
  Widget _buildMeasuringProgress() {
    return Column(
      children: [
        CircularProgressIndicator(
          value: controller.progress.value,
          backgroundColor: Colors.white.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 6,
        ),
        const SizedBox(height: 16),
        Text(
          controller.status.value,
          style: AppStyles.bodyMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${(controller.progress.value * 100).toInt()}%',
          style: AppStyles.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildMeasurementButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => controller.startCameraMeasurement(),
            icon: Icon(Icons.camera_alt, color: AppColors.primary),
            label: Text('الكاميرا المباشرة', style: TextStyle(color: AppColors.primary)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // سيتم تطوير رفع الفيديو لاحقاً
              Get.snackbar(
                'قريباً',
                'ميزة رفع الفيديو قيد التطوير',
                backgroundColor: AppColors.warning,
                colorText: Colors.white,
              );
            },
            icon: Icon(Icons.upload, color: Colors.white),
            label: Text('رفع فيديو', style: TextStyle(color: Colors.white)),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildHistorySection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'السجل التاريخي',
            style: AppStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() {
            final history = controller.heartRateHistory;
            if (history.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 60, color: AppColors.textSecondary),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد قراءات سابقة',
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            return Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final measurement = history[index];
                  return _buildHistoryItem(measurement);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildHistoryItem(HeartRateModel measurement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getHeartRateColor(measurement.heartRate).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite,
              color: _getHeartRateColor(measurement.heartRate),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${measurement.heartRate} نبضة/دقيقة',
                  style: AppStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  _formatDate(measurement.date),
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Chip(
            backgroundColor: _getHeartRateColor(measurement.heartRate).withOpacity(0.1),
            label: Text(
              _getHeartRateStatus(measurement.heartRate),
              style: TextStyle(
                color: _getHeartRateColor(measurement.heartRate),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getHeartRateColor(int heartRate) {
    if (heartRate < 60) return AppColors.warning;
    if (heartRate > 100) return AppColors.danger;
    return AppColors.success;
  }
  
  String _getHeartRateStatus(int heartRate) {
    if (heartRate < 60) return 'منخفض';
    if (heartRate > 100) return 'مرتفع';
    return 'طبيعي';
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}