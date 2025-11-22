class SignUpModel {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String gender;
  final int birthYear;
  final String location;

  SignUpModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.gender,
    required this.birthYear,
    required this.location,
  });
  int get age {
    final currentYear = DateTime.now().year;
    return currentYear - birthYear;
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'gender': gender,
      'birthYear': birthYear,
      'age': age,
      'location': location,
    };
  }
}
