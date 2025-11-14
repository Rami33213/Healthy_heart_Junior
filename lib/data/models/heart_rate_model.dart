// data/models/heart_rate_model.dart
class HeartRateModel {
  String? id;
  String? userId;
  int heartRate;
  DateTime date;
  String? method; // 'camera' or 'upload'
  double? confidence;
  
  HeartRateModel({
    this.id,
    this.userId,
    required this.heartRate,
    required this.date,
    this.method,
    this.confidence,
  });

  factory HeartRateModel.fromJson(Map<String, dynamic> json) {
    return HeartRateModel(
      id: json['id'],
      userId: json['userId'],
      heartRate: json['heartRate'],
      date: DateTime.parse(json['date']),
      method: json['method'],
      confidence: json['confidence']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'heartRate': heartRate,
      'date': date.toIso8601String(),
      'method': method,
      'confidence': confidence,
    };
  }
}