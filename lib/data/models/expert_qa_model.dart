// data/models/expert_qa_model.dart
class ExpertQAModel {
  String? id;
  String? userId;
  List<String> symptoms;
  String diagnosis;
  String recommendation;
  DateTime date;
  
  ExpertQAModel({
    this.id,
    this.userId,
    required this.symptoms,
    required this.diagnosis,
    required this.recommendation,
    required this.date,
  });

  factory ExpertQAModel.fromJson(Map<String, dynamic> json) {
    return ExpertQAModel(
      id: json['id'],
      userId: json['userId'],
      symptoms: List<String>.from(json['symptoms']),
      diagnosis: json['diagnosis'],
      recommendation: json['recommendation'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'recommendation': recommendation,
      'date': date.toIso8601String(),
    };
  }
}