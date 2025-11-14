// data/repositories/expert_repository.dart
import 'package:healthy_heart_junior/data/models/expert_qa_model.dart';

class ExpertRepository {
  static final ExpertRepository _instance = ExpertRepository._internal();
  factory ExpertRepository() => _instance;
  ExpertRepository._internal();
  
  static ExpertRepository get instance => _instance;
  
  final List<ExpertQAModel> _consultationData = [];
  
  Future<void> saveConsultation(ExpertQAModel consultation) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _consultationData.insert(0, consultation);
  }
  
  Future<List<ExpertQAModel>> getConsultationHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _consultationData;
  }
}