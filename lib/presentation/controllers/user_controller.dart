// presentation/controllers/user_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/theme/app_theme.dart';
import 'package:healthy_heart_junior/data/models/user_model.dart';
import 'package:healthy_heart_junior/data/repositories/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  
  final Rx<UserModel> currentUser = UserModel().obs;
  final RxBool isLoading = false.obs;
  final userRepository = UserRepository.instance;
  
  Future<void> loadUserData() async {
    isLoading.value = true;
    try {
      final user = await userRepository.getCurrentUser();
      currentUser.value = user;
    } catch (e) {
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
  
  Future<void> updateUserProfile(UserModel updatedUser) async {
    isLoading.value = true;
    try {
      await userRepository.updateUser(updatedUser);
      currentUser.value = updatedUser;
      Get.snackbar(
        'نجاح',
        'تم تحديث الملف الشخصي بنجاح',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في تحديث البيانات',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}