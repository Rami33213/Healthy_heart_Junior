// presentation/controllers/expert_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/theme/app_theme.dart';
import 'package:healthy_heart_junior/data/models/expert_qa_model.dart';
import 'package:healthy_heart_junior/data/repositories/expert_repository.dart';

class ExpertController extends GetxController {
  static ExpertController get instance => Get.find();
  
  final RxList<ExpertQAModel> consultationHistory = <ExpertQAModel>[].obs;
  final RxList<String> selectedSymptoms = <String>[].obs;
  final RxInt currentQuestionIndex = 0.obs;
  final RxBool consultationComplete = false.obs;
  final RxString diagnosis = ''.obs;
  final RxString recommendation = ''.obs;
  
  final expertRepository = ExpertRepository.instance;
  
  final List<ExpertQuestion> questions = [
    ExpertQuestion(
      'هل تشعر بألم في الصدر؟',
      ['ألم خفيف', 'ألم متوسط', 'ألم شديد', 'لا أشعر بألم'],
    ),
    ExpertQuestion(
      'ما طبيعة الألم؟',
      ['ألم حاد', 'ألم ضاغط', 'حرقة', 'وخز'],
    ),
    ExpertQuestion(
      'هل ينتشر الألم إلى أماكن أخرى؟',
      ['الذراع الأيسر', 'الذراع الأيمن', 'الرقبة', 'الفك', 'لا ينتشر'],
    ),
    ExpertQuestion(
      'ما هي الأعراض المصاحبة؟',
      ['ضيق تنفس', 'تعرق', 'غثيان', 'دوار', 'خفقان'],
    ),
    ExpertQuestion(
      'متى تظهر هذه الأعراض؟',
      ['أثناء الراحة', 'أثناء النشاط', 'بعد الأكل', 'لا وقت محدد'],
    ),
  ];
  
  void selectSymptom(String symptom) {
    if (selectedSymptoms.contains(symptom)) {
      selectedSymptoms.remove(symptom);
    } else {
      selectedSymptoms.add(symptom);
    }
  }
  
  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    } else {
      completeConsultation();
    }
  }
  
  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }
  
  void completeConsultation() {
    consultationComplete.value = true;
    
    // محاكاة تشخيص النظام الخبير
    if (selectedSymptoms.length > 3) {
      diagnosis.value = 'اشتباه في حالة قلبية';
      recommendation.value = 'نوصي بمراجعة طبيب القلب بشكل عاجل لإجراء فحوصات إضافية مثل تخطيط القلب والتحاليل المخبرية';
    } else if (selectedSymptoms.length > 1) {
      diagnosis.value = 'أعراض تستدعي المتابعة';
      recommendation.value = 'نوصي بمراجعة الطبيب في أقرب وقت ممكن مع متابعة الأعراض وتسجيل تطورها';
    } else {
      diagnosis.value = 'أعراض طبيعية أو بسيطة';
      recommendation.value = 'نوصي بالراحة ومتابعة الأعراض، وإذا استمرت يرجى مراجعة الطبيب';
    }
    
    final consultation = ExpertQAModel(
      symptoms: selectedSymptoms.toList(),
      diagnosis: diagnosis.value,
      recommendation: recommendation.value,
      date: DateTime.now(),
    );
    
    expertRepository.saveConsultation(consultation);
    consultationHistory.insert(0, consultation);
    
    Get.snackbar(
      'اكتمال الاستشارة',
      'تم تحليل الأعراض وتقديم التوصيات',
      backgroundColor: AppColors.success,
      colorText: Colors.white,
    );
  }
  
  void restartConsultation() {
    selectedSymptoms.clear();
    currentQuestionIndex.value = 0;
    consultationComplete.value = false;
    diagnosis.value = '';
    recommendation.value = '';
  }
  
  Future<void> loadConsultationHistory() async {
    try {
      final history = await expertRepository.getConsultationHistory();
      consultationHistory.assignAll(history);
    } catch (e) {
      print('Error loading consultation history: $e');
    }
  }
}

class ExpertQuestion {
  final String question;
  final List<String> options;
  
  ExpertQuestion(this.question, this.options);
}