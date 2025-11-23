// presentation/controllers/user_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/data/models/user_model.dart';
import 'package:healthy_heart_junior/data/repositories/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  
  final Rx<UserModel> currentUser = UserModel().obs;
  final RxBool isLoading = false.obs;
  final userRepository = UserRepository.instance;
  
  @override
  void onInit() {
    super.onInit();
    // ممكن تعتمد فقط على MainController، بس مافي مشكلة لو حمّل هنا كمان
    // loadUserData();
  }
  
  Future<void> loadUserData() async {
    isLoading.value = true;
    try {
      final user = await userRepository.getCurrentUser();
      currentUser.value = user;
      print('Loaded user: ${user.toJson()}');
    } catch (e) {
      print('LOAD USER ERROR: $e');
      Get.snackbar(
        'خطأ',
        'فشل في تحميل بيانات المستخدم',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  

}
