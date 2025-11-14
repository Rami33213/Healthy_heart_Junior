// data/models/ecg_model.dart
class EcgModel {
  String? id;
  String? userId;
  String ecgData; // ملف الـ ECG
  String result; // 'normal' or 'abnormal'
  double confidence;
  DateTime date;
  String? notes;
  
  EcgModel({
    this.id,
    this.userId,
    required this.ecgData,
    required this.result,
    required this.confidence,
    required this.date,
    this.notes,
  });

  factory EcgModel.fromJson(Map<String, dynamic> json) {
    return EcgModel(
      id: json['id'],
      userId: json['userId'],
      ecgData: json['ecgData'],
      result: json['result'],
      confidence: json['confidence']?.toDouble(),
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'ecgData': ecgData,
      'result': result,
      'confidence': confidence,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}