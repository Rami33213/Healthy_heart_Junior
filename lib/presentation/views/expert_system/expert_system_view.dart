// presentation/views/expert_system/expert_system_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/presentation/controllers/expert_controller.dart';

class ExpertSystemView extends GetView<ExpertController> {
  const ExpertSystemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                Expanded(
                  child: Obx(() {
                    if (controller.consultationComplete.value) {
                      return _buildResultsSection();
                    } else {
                      return _buildQuestionSection();
                    }
                  }),
                ),
              ],
            ),
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
          'النظام الخبير',
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuestionSection() {
    return Column(
      children: [
        // شريط التقدم
        _buildProgressBar(),
        const SizedBox(height: 32),
        
        // السؤال الحالي
        _buildCurrentQuestion(),
        const SizedBox(height: 24),
        
        // الخيارات
        _buildOptions(),
        const SizedBox(height: 32),
        
        // أزرار التنقل
        _buildNavigationButtons(),
      ],
    );
  }
  
  Widget _buildProgressBar() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (controller.currentQuestionIndex.value + 1) / controller.questions.length,
          backgroundColor: AppColors.background,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 8),
        Text(
          'السؤال ${controller.currentQuestionIndex.value + 1} من ${controller.questions.length}',
          style: AppStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCurrentQuestion() {
    return Obx(() {
      final currentQuestion = controller.questions[controller.currentQuestionIndex.value];
      return Container(
        padding: const EdgeInsets.all(24),
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
            Icon(Icons.medical_services, color: AppColors.primary, size: 40),
            const SizedBox(height: 16),
            Text(
              currentQuestion.question,
              style: AppStyles.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }
  
  Widget _buildOptions() {
    return Obx(() {
      final currentQuestion = controller.questions[controller.currentQuestionIndex.value];
      return Expanded(
        child: ListView.builder(
          itemCount: currentQuestion.options.length,
          itemBuilder: (context, index) {
            final option = currentQuestion.options[index];
            return _buildOptionItem(option);
          },
        ),
      );
    });
  }
  
  Widget _buildOptionItem(String option) {
    return Obx(() {
      final isSelected = controller.selectedSymptoms.contains(option);
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () => controller.selectSymptom(option),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        width: 2,
                      ),
                      color: isSelected ? AppColors.primary : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option,
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
  
  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (controller.currentQuestionIndex.value > 0) ...[
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => controller.previousQuestion(),
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
              label: Text('السابق', style: TextStyle(color: AppColors.primary)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => controller.nextQuestion(),
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            label: Text(
              controller.currentQuestionIndex.value == controller.questions.length - 1
                  ? 'انهاء الاستشارة'
                  : 'التالي',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
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
  
  Widget _buildResultsSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
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
              Icon(Icons.verified, color: Colors.white, size: 50),
              const SizedBox(height: 16),
              Text(
                'تم الانتهاء من الاستشارة',
                style: AppStyles.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        // التشخيص
        _buildResultCard(
          'التشخيص',
          controller.diagnosis.value,
          Icons.medical_services,
          AppColors.primary,
        ),
        const SizedBox(height: 16),
        
        // التوصيات
        _buildResultCard(
          'التوصيات',
          controller.recommendation.value,
          Icons.recommend,
          AppColors.accent,
        ),
        const SizedBox(height: 32),
        
        // الأعراض المختارة
        _buildSymptomsCard(),
        const SizedBox(height: 32),
        
        // زر البدء من جديد
        ElevatedButton.icon(
          onPressed: () => controller.restartConsultation(),
          icon: Icon(Icons.refresh, color: Colors.white),
          label: Text('بدء استشارة جديدة', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildResultCard(String title, String content, IconData icon, Color color) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSymptomsCard() {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list, color: AppColors.textPrimary, size: 20),
              const SizedBox(width: 8),
              Text(
                'الأعراض المختارة',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.selectedSymptoms.map((symptom) {
              return Chip(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                label: Text(
                  symptom,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}