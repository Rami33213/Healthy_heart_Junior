import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/presentation/controllers/auth/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // اللوجو
                    _buildLogo(),

                    // العنوان والتاغلاين
                    _buildAppInfo(),

                    // بطاقة التسجيل
                    _buildSignUpCard(),
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
      child: Icon(Icons.favorite_border, color: Colors.white, size: 35),
    );
  }

  Widget _buildAppInfo() {
    return Column(
      children: [
        Text("Healthy heart", style: AppStyles.authAppName),
        Text(
          "Because every heartbeat means life",
          style: AppStyles.authTagline,
        ),
      ],
    );
  }

  Widget _buildSignUpCard() {
    return Container(
      width: 370,
      height: 700,
      decoration: BoxDecoration(
        color: AppColors.authCardBackground,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
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
          _buildNameField(),
          _buildEmailField(),
          _buildPasswordField(),
          _buildPhoneField(),
          _buildLocationField(),
          _buildBirthDateField(),
          _buildGenderField(),
          _buildSignUpButton(),
          _buildTermsText(),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [Text("Welcome:", style: AppStyles.authWelcomeTitle)],
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller.fullNameController,
        validator: controller.validateName,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          label: const Text("Full name", style: AppStyles.authFieldLabel),
          prefixIcon: Icon(Icons.person, color: AppColors.authIconColor),
          constraints: const BoxConstraints(maxHeight: 60),
        ),
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
          label: const Text("Email", style: AppStyles.authFieldLabel),
          hint: const Text("example@exmail.com"),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: AppColors.authIconColor,
          ),
          constraints: const BoxConstraints(maxHeight: 60),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller.phoneController,
        validator: controller.validatePhone,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          label: const Text("Phone", style: AppStyles.authFieldLabel),
          prefixIcon: Icon(Icons.phone, color: AppColors.authIconColor),
          constraints: const BoxConstraints(maxHeight: 60),
        ),
      ),
    );
  }

  Widget _buildGenderField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Gender:", style: AppStyles.authFieldLabel),
          const SizedBox(height: 5),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<String>(
                      value: 'Male',
                      groupValue: controller.selectedGender.value,
                      onChanged: (value) => controller.setGender(value!),
                      activeColor: AppColors.authPrimary,
                    ),
                    title: Text('Male', style: AppStyles.bodyMedium),
                    onTap: () => controller.setGender('Male'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<String>(
                      value: 'Female',
                      groupValue: controller.selectedGender.value,
                      onChanged: (value) => controller.setGender(value!),
                      activeColor: AppColors.authPrimary,
                    ),
                    title: Text('Female', style: AppStyles.bodyMedium),
                    onTap: () => controller.setGender('Female'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBirthDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Birth Date: ", style: AppStyles.authFieldLabel),
          const SizedBox(height: 8),
          Row(
            children: [
              // اليوم
              Expanded(
                child: Obx(
                  () => Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.authFieldBackground,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedDay.value,
                        isExpanded: true,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.authIconColor,
                        ),
                        items: controller.days.map((String day) {
                          return DropdownMenuItem<String>(
                            value: day,
                            child: Text('$day', style: AppStyles.bodyMedium),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.setDay(newValue);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // الشهر
              Expanded(
                child: Obx(
                  () => Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.authFieldBackground,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedMonth.value,
                        isExpanded: true,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.authIconColor,
                        ),
                        items: controller.months.map((String month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text('$month ', style: AppStyles.bodyMedium),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.setMonth(newValue);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // السنة
              Expanded(
                child: Obx(
                  () => Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.authFieldBackground,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedYear.value,
                        isExpanded: true,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.authIconColor,
                        ),
                        items: controller.years.map((String year) {
                          return DropdownMenuItem<String>(
                            value: year,
                            child: Text(year, style: AppStyles.bodyMedium),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.setYear(newValue);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // عرض العمر المحسوب
          Obx(() {
            if (controller.calculatedAge.isEmpty) {
              return const SizedBox();
            }
            return Text(
              controller.calculatedAge.value,
              style: AppStyles.bodySmall.copyWith(
                color: controller.calculatedAge.value.contains('غير صحيح')
                    ? Colors.red
                    : AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLocationField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Location", style: AppStyles.authFieldLabel),
          const SizedBox(height: 8),
          Obx(
            () => Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.authFieldBackground,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 0,
                  color: AppColors.authFieldBackground,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedLocation.value,
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.authIconColor,
                  ),
                  items: controller.locations.map((String location) {
                    return DropdownMenuItem<String>(
                      value: location,
                      child: Text(location, style: AppStyles.bodyMedium),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.setLocation(newValue);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Obx(
        () => TextFormField(
          controller: controller.passwordController,
          validator: controller.validatePassword,
          obscureText: controller.hidePassword.value,
          maxLength: 8,
          decoration: InputDecoration(
            label: const Text("Password", style: AppStyles.authFieldLabel),
            helperText: "password must be at least 8 characters.",
            helperStyle: AppStyles.authHelperText,
            prefixIcon: Icon(Icons.lock, color: AppColors.authIconColor),
            suffixIcon: IconButton(
              onPressed: controller.togglePasswordVisibility,
              icon: Icon(
                controller.hidePassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
                color: AppColors.authIconColor,
              ),
            ),
            constraints: const BoxConstraints(maxHeight: 60),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Obx(
      () => Container(
        width: 320,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.authButtonBackground,
        ),
        child: MaterialButton(
          onPressed: controller.isLoading.value ? null : controller.signUp,
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Create account", style: AppStyles.authButtonText),
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppStyles.authFooterText,
          children: [
            const TextSpan(text: 'By signing up, you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: AppStyles.authLinkText,
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: AppStyles.authLinkText,
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
