// data/models/user_model.dart
class UserModel {
  String? id;
  String? name;
  String? email;
  String? gender;
  int? age;
  String? location;
  DateTime? createdAt;
  
  UserModel({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.age,
    this.location,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      age: json['age'],
      location: json['location'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'age': age,
      'location': location,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}