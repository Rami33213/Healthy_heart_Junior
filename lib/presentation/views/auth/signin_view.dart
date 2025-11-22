import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/presentation/controllers/auth/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only( top: 35.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // اللوجو
                    _buildLogo(),
                    
                    // العنوان والتاغلاين
                    _buildAppInfo(),
                    
                    // بطاقة تسجيل الدخول
                    _buildSignInCard(),
                    
                    // النص بالأسفل
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.authPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        Icons.favorite_border,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  Widget _buildAppInfo() {
    return Column(
      children: [
        Text(
          "Healthy heart",
          style: AppStyles.authAppName,
        ),
        Text(
          "Because every heartbeat means life",
          style: AppStyles.authTagline,
        ),
      ],
    );
  }

  Widget _buildSignInCard() {
    return Container(
      width: 370,
      height: 600,
      decoration: BoxDecoration(
        color: AppColors.authCardBackground,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.grey.shade200, 
          width: 1.5
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 7,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWelcomeHeader(),
          _buildEmailField(),
          _buildPasswordField(),
          _buildForgotPassword(),
          _buildRememberMe(),
          _buildSignInButton(),
          _buildOrDivider(),
          _buildGoogleButton(),
          _buildSignUpLink(),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Text(
            "Welcome Back:",
            style: AppStyles.authWelcomeTitle,
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller.emailController,
        validator: controller.validateEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          label: const Text(
            "Email",
            style: AppStyles.authFieldLabel,
          ),
          hint: const Text("example@exmail.com"),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: AppColors.authIconColor,
          ),
          constraints: const BoxConstraints(
            maxHeight: 70,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Obx(() => TextFormField(
        controller: controller.passwordController,
        validator: controller.validatePassword,
        obscureText: controller.hidePassword.value,
        maxLength: 8,
        decoration: InputDecoration(
          label: const Text(
            "Password",
            style: AppStyles.authFieldLabel,
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: AppColors.authIconColor,
          ),
          suffixIcon: IconButton(
            onPressed: controller.togglePasswordVisibility,
            icon: Icon(
              controller.hidePassword.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility,
              color: AppColors.authIconColor,
            ),
          ),
          constraints: const BoxConstraints(
            maxHeight: 70,
          ),
        ),
      )),
    );
  }

  Widget _buildForgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: controller.forgotPassword,
          child: Text(
            "Forget password ?",
            style: AppStyles.authLinkText,
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(() => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppColors.authPrimary,
        title: Text(
          "Keep me signed in",
          style: AppStyles.authCheckboxText,
        ),
        value: controller.keepSignedIn.value,
        onChanged: controller.toggleKeepSignedIn,
      )),
    );
  }

  Widget _buildSignInButton() {
    return Obx(() => Container(
      width: 320,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.authButtonBackground,
      ),
      child: MaterialButton(
        onPressed: controller.isLoading.value ? null : controller.signIn,
        child: controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Sign in",
                style: AppStyles.authButtonText,
              ),
      ),
    ));
  }

  Widget _buildOrDivider() {
    return Text(
      "OR",
      style: AppStyles.authOrText,
    );
  }

  Widget _buildGoogleButton() {
    return Obx(() => Container(
      width: 320,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.authGoogleButtonBackground,
      ),
      child: SignInButton(
        Buttons.Google,
        onPressed: controller.isLoading.value ? null : controller.signInWithGoogle,
      ),
    ));
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New to healthy heart?',
          style: AppStyles.authFooterText,
        ),
        TextButton(
          onPressed: controller.navigateToSignUp,
          child: Text(
            "Sign Up",
            style: AppStyles.authLinkText,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "protected by",
          style: AppStyles.authFooterText,
        ),
      ],
    );
  }
}