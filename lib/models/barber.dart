class BarberModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? instagram;
  final String? telegram;
  final bool isAvailable; // Switch orqali ishda yoki yo‘qligini ko‘rsatadi
  final bool isChecked;  // Sartaroshni aktivlashtirish
  final double rating;
  // final int totalReviews;
  final String? location;
  final List<Map<String, dynamic>> services;
  final List<Map<String, dynamic>> queue; // 🆕 Navbat listi
  final DateTime createdAt;
  final String? profileImage;
  final List<Map<String, dynamic>>? portfolio;

  BarberModel( {
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.instagram,
    this.telegram,
    required this.isAvailable,
    required this.isChecked,
    required this.rating,
    // required this.totalReviews,
    this.location,
    required this.services,
    required this.queue,
    required this.createdAt,
    this.profileImage,
    this.portfolio,
  });
//  Firestoredan barcha sartaroshlarni olish sartaroshni o'qish o'qish uchun
  factory BarberModel.allfromMap(Map<String, dynamic> data) {
    return BarberModel(
      id: data['id'] ?? [],
      fullName: data['fullName'],
      phoneNumber: data['phoneNumber'],
      instagram: data['instagram'],
      telegram: data['telegram'],
      isAvailable: data['isAvailable'],
      isChecked: data['isChecked'],
      rating: data['rating'].toDouble(),
      // totalReviews: data['totalReviews'],
      location: data['location'],
      services: List<Map<String, dynamic>>.from(data['services'] ?? []),
      queue: List<Map<String, dynamic>>.from(data['queue'] ?? []),
      createdAt: DateTime.parse(data['createdAt']),
      profileImage: data['profileImage'],
      portfolio: List<Map<String, dynamic>>.from(data['portfolio'] ?? [])
    );
  }

  //  Firestoredan bitta sartaroshni o'qish o'qish uchun
  factory BarberModel.fromMap(Map<String, dynamic> data, String documentId) {
    return BarberModel(
      id: documentId,
      fullName: data['fullName'],
      phoneNumber: data['phoneNumber'],
      instagram: data['instagram'],
      telegram: data['telegram'],
      isAvailable: data['isAvailable'],
      isChecked: data['isChecked'],
      rating: data['rating'].toDouble(),
      // totalReviews: data['totalReviews'],
      location: data['location'],
      services: List<Map<String, dynamic>>.from(data['services'] ?? []),
      queue: List<Map<String, dynamic>>.from(data['queue'] ?? []),
      createdAt: DateTime.parse(data['createdAt']),
      profileImage: data['profileImage'],
      portfolio: List<Map<String, dynamic>>.from(data['portfolio'] ?? [])

    );
  }

//Firestorega malumotlarni yuklash uchun
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'instagram': instagram,
      'telegram': telegram,
      'isAvailable': isAvailable,
      'isChecked':isChecked,
      'rating': rating,
      // 'totalReviews': totalReviews,
      'location': location,
      'services': services,
      'queue': queue,
      'createdAt': createdAt.toIso8601String(),
      'profileImage': profileImage,
      'portfolio':portfolio
    };
  }
}
