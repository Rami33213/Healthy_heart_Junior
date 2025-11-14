// data/repositories/user_repository.dart
import 'package:healthy_heart_junior/data/models/user_model.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  UserRepository._internal();
  
  static UserRepository get instance => _instance;
  
  Future<UserModel> getCurrentUser() async {
    // محاكاة جلب بيانات المستخدم
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: '1',
      name: 'أحمد محمد',
      email: 'ahmed@example.com',
      gender: 'ذكر',
      age: 35,
      location: 'الرياض',
      createdAt: DateTime.now(),
    );
  }
  
  Future<void> updateUser(UserModel user) async {
    // محاكاة تحديث البيانات
    await Future.delayed(const Duration(seconds: 1));
    print('User updated: ${user.toJson()}');
  }
}