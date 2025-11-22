import 'package:healthy_heart_junior/data/models/auth/sign_in_model.dart';
import 'package:healthy_heart_junior/data/models/auth/sign_up_model.dart';

class AuthRepository {
  Future<bool> signUp(SignUpModel userData) async {
    // محاكاة عملية التسجيل
    await Future.delayed(const Duration(seconds: 2));
    
    // في التطبيق الحقيقي، هنا سيتم الاتصال بالـ API
    print('User registered: ${userData.toJson()}');
    
    return true; // نجاح التسجيل
  }
  Future<bool> signIn(SignInModel userData) async {
    // محاكاة عملية تسجيل الدخول
    await Future.delayed(const Duration(seconds: 2));
    
    // في التطبيق الحقيقي، هنا سيتم الاتصال بالـ API
    print('User signed in: ${userData.toJson()}');
    
    return true; // نجاح تسجيل الدخول
  }
    Future<void> signInWithGoogle() async {
    // محاكاة تسجيل الدخول بـ Google
    await Future.delayed(const Duration(seconds: 2));
    print('User signed in with Google');
  }

  Future<void> forgotPassword(String email) async {
    // محاكاة عملية استعادة كلمة المرور
    await Future.delayed(const Duration(seconds: 2));
    print('Password reset requested for: $email');
  }


  // دوال التحقق من الصحة
  bool validateName(String name) {
    final nameRegex = RegExp(r"^[a-zA-Z\u0600-\u06FF]{2,}(?: [a-zA-Z\u0600-\u06FF]{2,})?$");
    return nameRegex.hasMatch(name.trim());
  }

  bool validateEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  bool validatePhone(String phone) {
    final syrianPhoneRegex = RegExp(r"^(?:\+963|0)9\d{8}$");
    return syrianPhoneRegex.hasMatch(phone.trim());
  }

  bool validatePassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(password);
  }
   bool validateBirthYear(String birthYear) {
    final year = int.tryParse(birthYear);
    if (year == null) return false;
    
    final currentYear = DateTime.now().year;
    final age = currentYear - year;
    
    return year >= 1900 && year <= currentYear && age >= 1 && age <= 120;
  }
}