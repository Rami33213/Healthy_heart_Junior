import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/presentation/views/ecg_analysis/ecg_history_view.dart';
import 'package:healthy_heart_junior/presentation/views/expert_system/expert_history_view.dart';
import 'package:healthy_heart_junior/presentation/views/heart_rate/heart_rate_history_view.dart';
import 'package:healthy_heart_junior/presentation/views/lab_analysis/lab_history_view.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: _buildReportsList(),
              ),
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
          'Medical reports',
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildReportsList() {
    return ListView(
      children: [
        _buildReportSection(
          'تقارير ضربات القلب',
          Icons.favorite,
          'عرض جميع قياسات نبض القلب',
          () => Get.to(() => const HeartRateHistoryView()),
        ),
        _buildReportSection(
          'تقارير تحليل ECG',
          Icons.monitor_heart_rounded,
          'عرض جميع تحاليل تخطيط القلب',
          () => Get.to(() => const EcgHistoryView()),
        ),
        _buildReportSection(
          'تقارير التحاليل المخبرية',
          Icons.science,
          'عرض نتائج التحاليل المخبرية',
          () => Get.to(() => const LabHistoryView()),
        ),
        _buildReportSection(
          'سجل الاستشارات',
          Icons.medical_services,
          'عرض تاريخ الاستشارات الطبية',
          () => Get.to(() => const ExpertHistoryView()),
        ),
      ],
    );
  }

  Widget _buildReportSection(
    String title,
    IconData icon,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppStyles.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}