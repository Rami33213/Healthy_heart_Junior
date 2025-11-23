class ApiConfig {
  static const String baseUrl = 'http://127.0.0.1:8000/api'; 

  static String get registerUrl => '$baseUrl/register';
  static String get loginUrl => '$baseUrl/login';
  static String get logoutUrl => '$baseUrl/logout';
  static String get profileUrl => '$baseUrl/profile';
  static String get currentUserUrl => '$baseUrl/user';
}
