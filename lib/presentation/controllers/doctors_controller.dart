import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/data/models/doctor_model.dart';
import 'package:healthy_heart_junior/data/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsController extends GetxController {
  final RxList<DoctorModel> doctors = <DoctorModel>[].obs;
  final RxBool isLoading = false.obs;
  // final RxString selectedSpecialty = 'جميع التخصصات'.obs;
  final RxString sortBy = 'الأقرب'.obs;

  // موقع المستخدم الافتراضي (يمكن استبداله بموقع حقيقي)
  final double userLatitude = 24.7136; // الرياض
  final double userLongitude = 46.6753;

  @override
  void onInit() {
    loadDoctors();
    super.onInit();
  }

  Future<void> loadDoctors() async {
    isLoading.value = true;
    
    try {
      await Future.delayed(const Duration(seconds: 2)); // محاكاة جلب البيانات
      
      // بيانات افتراضية للأطباء
      final mockDoctors = [
        DoctorModel(
          id: '1',
          name: 'د. أحمد محمد',
          specialty: 'أمراض القلب',
          hospital: 'مستشفى الملك فيصل التخصصي',
          address: 'الرياض، حي العليا',
          latitude: 24.7236,
          longitude: 46.6853,
          rating: 4.8,
          reviewCount: 127,
          imageUrl: 'https://example.com/doctor1.jpg',
          phone: '+966500000001',
          languages: ['العربية', 'الإنجليزية'],
        ),
        DoctorModel(
          id: '2',
          name: 'د. سارة الخالد',
          specialty: 'جراحة القلب',
          hospital: 'مستشفى الملك عبدالله التخصصي',
          address: 'الرياض، حي النخيل',
          latitude: 24.7036,
          longitude: 46.6653,
          rating: 4.9,
          reviewCount: 89,
          imageUrl: 'https://example.com/doctor2.jpg',
          phone: '+966500000002',
          languages: ['العربية', 'الإنجليزية'],
        ),
        // يمكن إضافة المزيد من الأطباء...
      ];

      // ترتيب الأطباء حسب المسافة
      final sortedDoctors = LocationService.sortDoctorsByDistance(
        mockDoctors, userLatitude, userLongitude
      );
      
      doctors.assignAll(sortedDoctors);
       sortBy.value = 'الأقرب';
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في تحميل بيانات الأطباء',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // void filterBySpecialty(String specialty) {
  //   selectedSpecialty.value = specialty;
  //   // يمكن تطبيق الفلتر هنا
  // }

  void sortDoctors(String sortType) {
    sortBy.value = sortType;
    if (sortType == 'الأقرب') {
      doctors.sort((a, b) => a.distance.compareTo(b.distance));
    } else {
      doctors.sort((a, b) => b.rating.compareTo(a.rating));
    } 
  }

  void refreshDoctors() {
    loadDoctors();
  }

  void contactDoctor(DoctorModel doctor) async {
    final url = 'tel:${doctor.phone}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar(
        'خطأ',
        'تعذر الاتصال بالطبيب',
        backgroundColor: AppColors.warning,
      );
    }
  }
}