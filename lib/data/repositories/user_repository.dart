import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:healthy_heart_junior/core/constants/api_config.dart';
import 'package:healthy_heart_junior/data/models/user_model.dart';
import 'package:healthy_heart_junior/data/repositories/auth_repository.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  UserRepository._internal();
  static UserRepository get instance => _instance;

  final AuthRepository _authRepository = AuthRepository();

  Future<UserModel> getCurrentUser() async {
    // 1) نجيب التوكن + بيانات اليوزر المخزّنة بعد الـ login
    final token = _authRepository.getToken();
    final storedUser = _authRepository.getStoredUser();

    if (token == null || storedUser == null) {
      throw Exception('Not authenticated');
    }

    // 2) نبني UserModel من بيانات User اللي رجعت من /login (جدول users)
    final baseUser = UserModel(
      id: storedUser['id']?.toString(),
      name: storedUser['name'],
      email: storedUser['email'],
      createdAt: DateTime.tryParse(storedUser['created_at'] ?? ''),
    );

    // 3) نجيب بيانات الـ profile من /api/profile
    final profileResponse = await http.get(
      Uri.parse(ApiConfig.profileUrl),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('PROFILE STATUS: ${profileResponse.statusCode}');
    print('PROFILE BODY: ${profileResponse.body}');

    if (profileResponse.statusCode == 200 &&
        profileResponse.body.isNotEmpty &&
        profileResponse.body != 'null') {
      final profileJson = jsonDecode(profileResponse.body);

      // 4) نرجّع UserModel مدموج: بيانات users + profiles
      return UserModel(
        id: baseUser.id,
        name: baseUser.name,
        email: baseUser.email,
        createdAt: baseUser.createdAt,
        gender: profileJson['gender'],
        location: profileJson['address'],
        age: _calculateAgeFromProfile(profileJson['date_of_birth']),
      );
    }

    // لو ما في بروفايل، نرجع بس بيانات اليوزر الأساسية
    return baseUser;
  }

  int? _calculateAgeFromProfile(String? dateOfBirth) {
    if (dateOfBirth == null) return null;
    try {
      final dob = DateTime.parse(dateOfBirth);
      final now = DateTime.now();
      int age = now.year - dob.year;
      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        age--;
      }
      return age;
    } catch (_) {
      return null;
    }
  }

  Future<void> updateUser(UserModel user) async {
    // ما عندك endpoint لتحديث اليوزر لسه، فخليها Mock مؤقتاً
    print('User updated: ${user.toJson()}');
  }
}
