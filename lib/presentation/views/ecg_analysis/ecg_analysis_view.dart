// presentation/views/ecg_analysis/ecg_analysis_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/data/models/ecg_model.dart';
import 'package:healthy_heart_junior/presentation/controllers/ecg_controller.dart';

class EcgAnalysisView extends GetView<EcgController> {
  const EcgAnalysisView({super.key});

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
              _buildAnalysisSection(),
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
          'تحليل إشارات ECG',
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildAnalysisSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.heat_pump_rounded, color: AppColors.primary, size: 50),
          const SizedBox(height: 16),
          Text(
            'تحليل تخطيط القلب الكهربائي',
            style: AppStyles.titleLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'قم برفع ملف ECG لتحليله باستخدام الذكاء الاصطناعي',
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          Obx(() {
            if (controller.isAnalyzing.value) {
              return _buildAnalysisProgress();
            } else {
              return _buildUploadButton();
            }
          }),
        ],
      ),
    );
  }
  
  // في presentation/views/ecg_analysis/ecg_analysis_view.dart
// استبدل الـ Obx بهذا:

// وتأكد من أن الدوال تستخدم الأنماط الأساسية:

Widget _buildAnalysisProgress() {
  return Column(
    children: [
      CircularProgressIndicator(
        value: controller.analysisProgress.value,
        backgroundColor: const Color(0xFF2E5BFF).withOpacity(0.3),
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E5BFF)),
        strokeWidth: 6,
      ),
      const SizedBox(height: 16),
      Text(
        controller.analysisStatus.value,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF2D3748),
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '${(controller.analysisProgress.value * 100).toInt()}%',
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF2E5BFF),
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
  Widget _buildUploadButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // محاكاة رفع ملف
        final fakeFilePath = 'assets/sample_ecg.csv';
        controller.analyzeECG(fakeFilePath);
      },
      icon: Icon(Icons.upload_file, color: Colors.white),
      label: Text('رفع ملف ECG', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
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
            final history = controller.ecgHistory;
            if (history.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 60, color: AppColors.textSecondary),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد تحليلات سابقة',
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
                  final analysis = history[index];
                  return _buildHistoryItem(analysis);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildHistoryItem(EcgModel analysis) {
    final isNormal = analysis.result == 'normal';
    
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
              color: (isNormal ? AppColors.success : AppColors.danger).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isNormal ? Icons.check_circle : Icons.warning,
              color: isNormal ? AppColors.success : AppColors.danger,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isNormal ? 'طبيعي' : 'غير طبيعي',
                  style: AppStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  _formatDate(analysis.date),
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (analysis.notes != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    analysis.notes!,
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Chip(
            backgroundColor: (isNormal ? AppColors.success : AppColors.danger).withOpacity(0.1),
            label: Text(
              '${(analysis.confidence * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                color: isNormal ? AppColors.success : AppColors.danger,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}