import 'dart:math';
import 'package:healthy_heart_junior/data/models/doctor_model.dart';

class LocationService {
  // حساب المسافة بين نقطتين باستخدام Haversine formula
  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // نصف قطر الأرض بالكيلومتر

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return R * c;
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }

  // ترتيب الأطباء حسب الأقرب
  static List<DoctorModel> sortDoctorsByDistance(
    List<DoctorModel> doctors, 
    double userLat, 
    double userLon
  ) {
    for (var doctor in doctors) {
      doctor.distance = calculateDistance(
        userLat, userLon, doctor.latitude, doctor.longitude
      );
    }
    
    doctors.sort((a, b) => a.distance.compareTo(b.distance));
    return doctors;
  }
}