class UserModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  // final String? telegramId; // Telegram orqali autentifikatsiya uchun
  final String? currentBarber; // 'customer' yoki 'barber'
  final String? profileImageUrl;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    // this.telegramId,
    this.currentBarber,
    this.profileImageUrl,
    required this.createdAt,
  });
//  Firestoredan o'qish uchun
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      fullName: data['fullName'],
      phoneNumber: data['phoneNumber'],
      // telegramId: data['telegramId'],
      currentBarber: data['currentBarber'],
      profileImageUrl: data['profileImageUrl'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }
// FireStorega yozish uchun
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      // 'telegramId': telegramId,
      'currentBarber': currentBarber,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
UserModel copyWith({
    String? id,
    String? fullName,
    String? currentBarber,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      currentBarber: currentBarber ?? this.currentBarber, 
      phoneNumber: phoneNumber, 
      createdAt: createdAt,
      
    );
  }

}
