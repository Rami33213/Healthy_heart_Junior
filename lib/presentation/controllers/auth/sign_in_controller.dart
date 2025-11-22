import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/data/models/auth/sign_in_model.dart';
import 'package:healthy_heart_junior/data/repositories/auth_repository.dart';

class SignInController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  
  final RxBool isLoading = false.obs;
  final RxBool hidePassword = true.obs;
  final RxBool keepSignedIn = false.obs;
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  void toggleKeepSignedIn(bool? value) {
    keepSignedIn.value = value ?? false;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required to continue";
    } else if (!_authRepository.validateEmail(value)) {
      return "Email must be in the format: example@gmail.com";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required to continue";
    } else if (value.length < 8 || !_authRepository.validatePassword(value)) {
      return "Password must be at least 8 characters.";
    }
    return null;
  }

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      final userData = SignInModel(
        email: emailController.text.trim(),
        password: passwordController.text,
        keepSignedIn: keepSignedIn.value,
      );

      final success = await _authRepository.signIn(userData);

      if (success) {
        Get.snackbar(
          "Success",
          "Welcome back!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // الانتقال للشاشة الرئيسية
        Get.offAllNamed('/main');
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to sign in. Please check your credentials.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;

    try {
      await _authRepository.signInWithGoogle();
      Get.snackbar(
        "Success",
        "Signed in with Google successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // الانتقال للشاشة الرئيسية
      Get.offAllNamed('/main');
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to sign in with Google.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (emailController.text.isEmpty || !_authRepository.validateEmail(emailController.text)) {
      Get.snackbar(
        "Error",
        "Please enter a valid email address",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      await _authRepository.forgotPassword(emailController.text.trim());
      Get.snackbar(
        "Success",
        "Password reset instructions sent to your email",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send reset instructions",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToSignUp() {
    Get.toNamed('/signup');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}