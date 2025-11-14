// presentation/controllers/main_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import 'user_controller.dart';
import 'heart_rate_controller.dart';
import 'ecg_controller.dart';
import 'lab_controller.dart';
import 'expert_controller.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/heart_rate/heart_rate_view.dart';
import '../../presentation/views/ecg_analysis/ecg_analysis_view.dart';
import '../../presentation/views/lab_analysis/lab_analysis_view.dart';
import '../../presentation/views/expert_system/expert_system_view.dart';
import '../../presentation/views/settings/settings_view.dart';

class MainController extends GetxController {
  static MainController get instance => Get.find();
  
  final RxInt currentIndex = 0.obs;
  final Rx<UserModel> currentUser = UserModel().obs;
  final RxBool isLoading = false.obs;
  
  final List<BottomNavItem> navItems = [
    BottomNavItem('الرئيسية', Icons.home_filled, const HomeView()),
    BottomNavItem('ضربات القلب', Icons.favorite, const HeartRateView()),
    BottomNavItem('ECG', Icons.monitor_heart_outlined, const EcgAnalysisView()),
    BottomNavItem('المختبر', Icons.science, const LabAnalysisView()),
    BottomNavItem('الخبير', Icons.medical_services, const ExpertSystemView()),
  ];
  
  @override
  void onInit() {
    _initializeApp();
    super.onInit();
  }
  
  Future<void> _initializeApp() async {
    isLoading.value = true;
    try {
      // تحميل بيانات المستخدم
      await UserController.instance.loadUserData();
      
      // تحميل السجلات التاريخية
      await HeartRateController.instance.loadHeartRateHistory();
      await EcgController.instance.loadECGHistory();
      await LabController.instance.loadLabHistory();
      await ExpertController.instance.loadConsultationHistory();
      
      currentUser.value = UserController.instance.currentUser.value;
    } catch (e) {
      print('Error initializing app: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  void changeTab(int index) {
    currentIndex.value = index;
  }
  
  void navigateToSettings() {
    Get.to(() => const SettingsView());
  }
}

class BottomNavItem {
  final String label;
  final IconData icon;
  final Widget screen;
  
  const BottomNavItem(this.label, this.icon, this.screen);
}