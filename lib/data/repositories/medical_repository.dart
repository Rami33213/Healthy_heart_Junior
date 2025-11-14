// data/repositories/medical_repository.dart
import 'package:healthy_heart_junior/data/models/ecg_model.dart';
import 'package:healthy_heart_junior/data/models/heart_rate_model.dart';
import 'package:healthy_heart_junior/data/models/lab_model.dart';

class MedicalRepository {
  static final MedicalRepository _instance = MedicalRepository._internal();
  factory MedicalRepository() => _instance;
  MedicalRepository._internal();
  
  static MedicalRepository get instance => _instance;
  
  final List<HeartRateModel> _heartRateData = [];
  final List<EcgModel> _ecgData = [];
  final List<LabModel> _labData = [];
  
  Future<void> saveHeartRate(HeartRateModel measurement) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _heartRateData.insert(0, measurement);
  }
  
  Future<List<HeartRateModel>> getHeartRateHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _heartRateData;
  }
  
  Future<void> saveECG(EcgModel ecg) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _ecgData.insert(0, ecg);
  }
  
  Future<List<EcgModel>> getECGHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _ecgData;
  }
  
  Future<void> saveLabAnalysis(LabModel lab) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _labData.insert(0, lab);
  }
  
  Future<List<LabModel>> getLabHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _labData;
  }
}