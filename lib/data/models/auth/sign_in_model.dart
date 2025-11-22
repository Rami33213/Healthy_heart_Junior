class SignInModel {
  final String email;
  final String password;
  final bool keepSignedIn;

  SignInModel({
    required this.email,
    required this.password,
    required this.keepSignedIn,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'keepSignedIn': keepSignedIn,
    };
  }
}