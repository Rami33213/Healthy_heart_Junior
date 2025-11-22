class DoctorModel {
  String id;
  String name;
  String specialty;
  String hospital;
  String address;
  double latitude;
  double longitude;
  double distance; // سيتم حسابه
  double rating;
  int reviewCount;
  String imageUrl;
  String phone;
  List<String> languages;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.phone,
    required this.languages,
    this.distance = 0.0,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      hospital: json['hospital'],
      address: json['address'],
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      phone: json['phone'] ?? '',
      languages: List<String>.from(json['languages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'hospital': hospital,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageUrl': imageUrl,
      'phone': phone,
      'languages': languages,
    };
  }
}