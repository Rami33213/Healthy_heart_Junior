// data/models/lab_model.dart
class LabModel {
  String? id;
  String? userId;
  int heartRate;
  int systolicBP; // الضغط الانقباضي
  int diastolicBP; // الضغط الانبساطي
  double bloodSugar; // السكر في الدم
  double ckMb; // إنزيم CK-MB
  double troponin; // بروتين Troponin
  String result; // 'normal' or 'risk'
  double confidence;
  DateTime date;
  
  LabModel({
    this.id,
    this.userId,
    required this.heartRate,
    required this.systolicBP,
    required this.diastolicBP,
    required this.bloodSugar,
    required this.ckMb,
    required this.troponin,
    required this.result,
    required this.confidence,
    required this.date,
  });

  factory LabModel.fromJson(Map<String, dynamic> json) {
    return LabModel(
      id: json['id'],
      userId: json['userId'],
      heartRate: json['heartRate'],
      systolicBP: json['systolicBP'],
      diastolicBP: json['diastolicBP'],
      bloodSugar: json['bloodSugar']?.toDouble(),
      ckMb: json['ckMb']?.toDouble(),
      troponin: json['troponin']?.toDouble(),
      result: json['result'],
      confidence: json['confidence']?.toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'heartRate': heartRate,
      'systolicBP': systolicBP,
      'diastolicBP': diastolicBP,
      'bloodSugar': bloodSugar,
      'ckMb': ckMb,
      'troponin': troponin,
      'result': result,
      'confidence': confidence,
      'date': date.toIso8601String(),
    };
  }
}