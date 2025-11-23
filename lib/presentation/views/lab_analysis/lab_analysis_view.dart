// presentation/views/lab_analysis/lab_analysis_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/data/models/lab_model.dart';
import 'package:healthy_heart_junior/presentation/controllers/lab_controller.dart';

class LabAnalysisView extends GetView<LabController> {
  const LabAnalysisView({super.key});

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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildInputSection(),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
                      const SizedBox(height: 24),
                      _buildHistorySection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────── header ─────────
  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        const SizedBox(width: 8),
        Text(
          'تحليل التحاليل الطبية',
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ───────── input section ─────────
  Widget _buildInputSection() {
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
          Icon(Icons.science, color: AppColors.accent, size: 50),
          const SizedBox(height: 16),
          Text(
            'أدخل نتائج التحاليل الطبية',
            style: AppStyles.titleLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // معدل ضربات القلب
          _buildLabInputField(
            label: 'معدل ضربات القلب',
            unit: 'نبضة/دقيقة',
            value: controller.heartRate,
            icon: Icons.favorite,
            color: AppColors.danger,
          ),
          const SizedBox(height: 16),

          // الضغط الانقباضي والانبساطي
          Row(
            children: [
              Expanded(
                child: _buildLabInputField(
                  label: 'الضغط الانقباضي',
                  unit: 'mmHg',
                  value: controller.systolicBP,
                  icon: Icons.monitor_heart,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabInputField(
                  label: 'الضغط الانبساطي',
                  unit: 'mmHg',
                  value: controller.diastolicBP,
                  icon: Icons.monitor_heart,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // السكر
          _buildLabInputField(
            label: 'مستوى السكر في الدم',
            unit: 'mg/dL',
            value: controller.bloodSugar,
            icon: Icons.water_drop,
            color: AppColors.warning,
          ),
          const SizedBox(height: 16),

          // CK-MB & Troponin
          Row(
            children: [
              Expanded(
                child: _buildLabInputField(
                  label: 'إنزيم CK-MB',
                  unit: 'U/L',
                  value: controller.ckMb,
                  icon: Icons.biotech,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabInputField(
                  label: 'بروتين Troponin',
                  unit: 'ng/mL',
                  value: controller.troponin,
                  icon: Icons.biotech,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// حقل إدخال رقمي عام لكل القيم
  Widget _buildLabInputField({
    required String label,
    required String unit,
    required RxDouble value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.textSecondary.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(() {
                  return TextField(
                    controller: TextEditingController(
                      text: value.value.toString(),
                    ),
                    onChanged: (text) =>
                        controller.updateValue(value, text),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'أدخل $label',
                    ),
                  );
                }),
              ),
              Text(
                unit,
                style: AppStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ───────── action buttons ─────────
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Obx(() {
            return ElevatedButton.icon(
              onPressed: controller.isAnalyzing.value
                  ? null
                  : controller.analyzeLabResults,
              icon: controller.isAnalyzing.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.analytics, color: Colors.white),
              label: Text(
                controller.isAnalyzing.value
                    ? 'جاري التحليل...'
                    : 'تحليل النتائج',
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: controller.resetForm,
          icon: Icon(Icons.refresh, color: AppColors.primary),
          label: Text(
            'إعادة تعيين',
            style: TextStyle(color: AppColors.primary),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.primary),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  // ───────── history section ─────────
  Widget _buildHistorySection() {
    return Column(
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
          final history = controller.labHistory;

          if (history.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(Icons.history,
                      size: 60, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد تحليلات سابقة',
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: history
                .take(3)
                .map((analysis) => _buildHistoryItem(analysis))
                .toList(),
          );
        }),
      ],
    );
  }

  Widget _buildHistoryItem(LabModel analysis) {
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
              color: (isNormal ? AppColors.success : AppColors.warning)
                  .withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isNormal ? Icons.verified : Icons.warning_amber,
              color: isNormal ? AppColors.success : AppColors.warning,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isNormal ? 'نتيجة طبيعية' : 'خطر محتمل',
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
                Text(
                  '${analysis.heartRate} نبضة - '
                  '${analysis.systolicBP}/${analysis.diastolicBP} ضغط',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Chip(
            backgroundColor: (isNormal ? AppColors.success : AppColors.warning)
                .withOpacity(0.1),
            label: Text(
              '${(analysis.confidence * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                color:
                    isNormal ? AppColors.success : AppColors.warning,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
