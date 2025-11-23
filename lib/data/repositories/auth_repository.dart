// data/repositories/auth_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:healthy_heart_junior/core/constants/api_config.dart';
import 'package:healthy_heart_junior/data/models/auth/sign_in_model.dart';
import 'package:healthy_heart_junior/data/models/auth/sign_up_model.dart';

class AuthRepository {
  final _storage = GetStorage();

  // مفاتيح التخزين
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  // ========= Helpers عامة =========

  Future<void> _saveAuthData(String token, Map<String, dynamic> user) async {
    await _storage.write(_tokenKey, token);
    await _storage.write(_userKey, user);
  }

  String? getToken() {
    return _storage.read<String>(_tokenKey);
  }

  Map<String, dynamic>? getStoredUser() {
    return _storage.read<Map<String, dynamic>>(_userKey);
  }

  Future<void> clearAuthData() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userKey);
  }

  Map<String, String> _jsonHeaders({bool withAuth = false}) {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (withAuth) {
      final token = getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // ========= التحقق (نفس دوالك السابقة) =========

  bool validateName(String name) {
    final nameRegex = RegExp(
      r"^[a-zA-Z\u0600-\u06FF]{2,}(?: [a-zA-Z\u0600-\u06FF]{2,})?$",
    );
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
    final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );
    return passwordRegExp.hasMatch(password);
  }

  bool validateBirthYear(String birthYear) {
    final year = int.tryParse(birthYear);
    if (year == null) return false;

    final currentYear = DateTime.now().year;
    final age = currentYear - year;

    return year >= 1900 && year <= currentYear && age >= 1 && age <= 120;
  }

  // ========= signUp (Register + Login + Profile) =========

  Future<bool> signUp(SignUpModel userData, DateTime birthDate) async {
    // 1) register
    final registerBody = {
      'name': userData.fullName,
      'email': userData.email,
      'phone': userData.phone,
      'password': userData.password,
      'password_confirmation': userData.password,
    };

    final registerResponse = await http.post(
      Uri.parse(ApiConfig.registerUrl),
      headers: _jsonHeaders(),
      body: jsonEncode(registerBody),
    );

    if (registerResponse.statusCode != 201) {
      // اقرأ الرسالة من الباك إن أمكن
      final body = jsonDecode(registerResponse.body);
      throw Exception(body['message'] ?? 'Failed to register');
    }

    // 2) login بعد التسجيل مباشرة
    final loginBody = {'email': userData.email, 'password': userData.password};

    final loginResponse = await http.post(
      Uri.parse(ApiConfig.loginUrl),
      headers: _jsonHeaders(),
      body: jsonEncode(loginBody),
    );

    if (loginResponse.statusCode != 201) {
      throw Exception('Registered but failed to login');
    }

    final loginJson = jsonDecode(loginResponse.body);
    final token = loginJson['Token'] as String;
    final user = loginJson['User'] as Map<String, dynamic>;

    await _saveAuthData(token, user);

    // 3) إنشاء / تحديث البروفايل
    final String dateOfBirth =
        "${birthDate.year.toString().padLeft(4, '0')}-"
        "${birthDate.month.toString().padLeft(2, '0')}-"
        "${birthDate.day.toString().padLeft(2, '0')}";

    final profileBody = {
      'address': userData.location,
      'date_of_birth': dateOfBirth,
      'gender': userData.gender.toLowerCase() == 'male' ? 'male' : 'female',
    };

    final profileResponse = await http.post(
      Uri.parse(ApiConfig.profileUrl),
      headers: _jsonHeaders(withAuth: true),
      body: jsonEncode(profileBody),
    );

    if (profileResponse.statusCode != 201) {
      // مو critical بس حلو تعرف لو صار خطأ
      print('Profile create/update failed: ${profileResponse.body}');
    }

    return true;
  }

  // ========= signIn =========

  // داخل AuthRepository

  Future<bool> signIn(SignInModel userData) async {
    try {
      final body = {
        'email': userData.email,
        'password': userData.password,
        // ما نبعت keepSignedIn للـ backend لأنه ما بيستخدمها
      };

      final response = await http.post(
        Uri.parse(ApiConfig.loginUrl),
        headers: _jsonHeaders(),
        body: jsonEncode(body),
      );

      print('LOGIN STATUS: ${response.statusCode}');
      print('LOGIN BODY: ${response.body}');

      if (response.statusCode != 201) {
        // هون بيكون يا 401 (كلمة سر غلط) أو 422 (validation) أو غيره
        return false;
      }

      final json = jsonDecode(response.body);

      // تأكد من اسم الحقول بالظبط مثل لارفيل:
      //  'User'  و 'Token'
      final token = json['Token'] as String?;
      final user = json['User'] as Map<String, dynamic>?;

      if (token == null || user == null) {
        // لو صار تغيّر بالأسماء أو الريسبونس
        print('LOGIN JSON INVALID: $json');
        return false;
      }

      await _saveAuthData(token, user);

      // لو حاب تخزن keepSignedIn داخليًا عندك بس
      await _storage.write('keep_signed_in', userData.keepSignedIn);

      return true;
    } catch (e) {
      print('LOGIN ERROR: $e');
      rethrow; // هاد رح يروح على الـ catch تبع SignInController
    }
  }

  // ========= Google SignIn (لسه Mock) =========

  Future<void> signInWithGoogle() async {
    // لحد الآن ما عندك endpoint في Laravel، خليه Mock مؤقتاً
    await Future.delayed(const Duration(seconds: 2));
    print('User signed in with Google (mock)');
  }

  // ========= Forgot Password (ما عندك route حالياً) =========

  Future<void> forgotPassword(String email) async {
    // ما عندك /password/forgot مثلاً، فخليها مؤقتاً Mock
    await Future.delayed(const Duration(seconds: 2));
    print('Password reset requested for: $email');
  }

  // ========= Logout =========

  Future<void> logout() async {
    final token = getToken();
    if (token == null) {
      await clearAuthData();
      return;
    }

    final response = await http.post(
      Uri.parse(ApiConfig.logoutUrl),
      headers: _jsonHeaders(withAuth: true),
    );

    // حتى لو رجع error، امسح الداتا محلياً
    await clearAuthData();

    print('Logout response: ${response.statusCode} - ${response.body}');
  }
}
