import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/data/models/auth/sign_up_model.dart';
import 'package:healthy_heart_junior/data/repositories/auth_repository.dart';

class SignUpController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final RxBool isLoading = false.obs;
  final RxBool hidePassword = true.obs;
  final RxString selectedGender = 'Male'.obs;
  final RxString selectedLocation = 'Damascus'.obs;
  final RxString calculatedAge = ''.obs;

   final RxString selectedDay = '1'.obs;
  final RxString selectedMonth = '1'.obs;
  final RxString selectedYear = '2000'.obs;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<String> locations = [
    'Damascus',
    'Aleppo',
    'Homs',
    'Hama',
    'Latakia',
    'Deir ez-Zor',
    'Al-Hasakah',
    'Raqqa',
    'Daraa',
    'Al-Suwayda',
    'Tartus',
    'Idlib',
    'Quneitra',
    'Rif Dimashq'
  ];

  List<String> get years {
    final currentYear = DateTime.now().year;
    return List.generate(100, (index) => (currentYear - 99 + index).toString());
  }
 List<String> get months => List.generate(12, (index) => (index + 1).toString());
  
List<String> get days {
    final month = int.tryParse(selectedMonth.value);
    final year = int.tryParse(selectedYear.value);
    
    if (month == null || year == null) return List.generate(31, (index) => (index + 1).toString());
    
    final daysInMonth = getDaysInMonth(month, year);
    return List.generate(daysInMonth, (index) => (index + 1).toString());
  }
 int getDaysInMonth(int month, int year) {
    if (month == 2) {
      // فبراير - التحقق من السنة الكبيسة
      return isLeapYear(year) ? 29 : 28;
    } else if ([4, 6, 9, 11].contains(month)) {
      // أشهر 30 يوم
      return 30;
    } else {
      // أشهر 31 يوم
      return 31;
    }
  }
  // التحقق من السنة الكبيسة
  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // تحديث الأيام عند تغيير الشهر أو السنة
  void updateDays() {
    final currentDay = int.tryParse(selectedDay.value);
    final daysInMonth = getDaysInMonth(
      int.parse(selectedMonth.value), 
      int.parse(selectedYear.value)
    );
    
    // إذا كان اليوم المختار أكبر من أيام الشهر الجديد، اختر آخر يوم
    if (currentDay != null && currentDay > daysInMonth) {
      selectedDay.value = daysInMonth.toString();
    } else {
      selectedDay.value = selectedDay.value; // لتحديث الـ UI
    }
  }

  int calculateAge(int year, int month, int day) {
    final now = DateTime.now();
    final birthDate = DateTime(year, month, day);
    
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void updateCalculatedAge() {
    final year = int.tryParse(selectedYear.value);
    final month = int.tryParse(selectedMonth.value);
    final day = int.tryParse(selectedDay.value);
    
    if (year == null || month == null || day == null) {
      calculatedAge.value = '';
      return;
    }
    
    // التحقق من تاريخ صحيح
    if (!isValidDate(day, month, year)) {
      calculatedAge.value = 'Invalid date  ';
      return;
    }
    
    final age = calculateAge(year, month, day);
    calculatedAge.value = 'العمر: $age سنة';
  }

  bool isValidDate(int day, int month, int year) {
    try {
      final date = DateTime(year, month, day);
      return date.year == year && date.month == month && date.day == day;
    } catch (e) {
      return false;
    }
  }

  String? validateBirthDate() {
    final year = int.tryParse(selectedYear.value);
    final month = int.tryParse(selectedMonth.value);
    final day = int.tryParse(selectedDay.value);
    
    if (year == null || month == null || day == null) {
      return "Please select a valid birth date";
    }
    
    if (!isValidDate(day, month, year)) {
      return "Invalid birth date";
    }
    
    final age = calculateAge(year, month, day);
    if (age < 1) {
      return "You must be at least 1 year old";
    }
    
    if (age > 120) {
      return "Please check your birth date";
    }
    
    return null;
  }

  // الحصول على تاريخ الميلاد كـ DateTime
  DateTime get birthDate {
    return DateTime(
      int.parse(selectedYear.value),
      int.parse(selectedMonth.value),
      int.parse(selectedDay.value),
    );
  }


  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setLocation(String location) {
    selectedLocation.value = location;
  }
 void setDay(String day) {
    selectedDay.value = day;
    updateCalculatedAge();
  }

  void setMonth(String month) {
    selectedMonth.value = month;
     updateDays();
    updateCalculatedAge();
  }

  void setYear(String year) {
    selectedYear.value = year;
    updateDays();
    updateCalculatedAge();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your full name, Full name is required to continue";
    } else if (!_authRepository.validateName(value)) {
      return "Name must contain at least two letters";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required to continue";
    } else if (!_authRepository.validateEmail(value)) {
      return "Email must be in the format: example@gmail.com";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required to continue";
    } else if (!_authRepository.validatePhone(value)) {
      return "phone number that starts with 09xxxxxxxx or +9639xxxxxxxx";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required to continue";
    } else if (!_authRepository.validatePassword(value)) {
      return "Password must contain at least 8 characters, one uppercase letter, one number, and one special character";
    }
    return null;
  }

Future<void> signUp() async {
  final birthDateError = validateBirthDate();
  if (birthDateError != null) {
    Get.snackbar(
      "Error",
      birthDateError,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return;
  }

  if (!formKey.currentState!.validate()) {
    return;
  }

  isLoading.value = true;

  try {
    final userData = SignUpModel(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text,
      gender: selectedGender.value,
      birthYear: birthDate.year,
      location: selectedLocation.value,
    );

    // 🔴 التعديل هون: مرّر الـ birthDate للريبو
    final success = await _authRepository.signUp(userData, birthDate);

    if (success) {
      Get.snackbar(
        "Success",
        "Welcome! Account created successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/main');
    }
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to create account. Please try again.",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    isLoading.value = false;
  }
}

   @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
