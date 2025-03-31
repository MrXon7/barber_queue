import 'package:barber_queue/models/barber.dart';
import 'package:barber_queue/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  int? _queuePosition;
  List<BarberModel> _barbers = [];
  List<BarberModel> _filteredBarbers = [];

  List<BarberModel> get barbers => _barbers;
  List<BarberModel> get filteredBarbers => _filteredBarbers;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? get user => _user;
  int? get queuePosition => _queuePosition;

  /// 🔹 Foydalanuvchi ma’lumotlarini Firestore-dan yuklash
  Future<void> fetchUser(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        _user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>, userId);
        notifyListeners();
      }
    } catch (e) {
      print("❌ Xatolik: ${e.toString()}");
    }
  }

  /// 🔹 Foydalanuvchi ma’lumotlarini **real vaqt rejimida** olish
  // void listenToUser(String userId) {
  //   _firestore.collection('users').doc(userId).snapshots().listen((userDoc) {
  //     if (userDoc.exists) {
  //       _user =
  //           UserModel.fromMap(userDoc.data() as Map<String, dynamic>, userId);
  //       notifyListeners();
  //     }
  //   });
  // }

  /// 🔹 Foydalanuvchini yangilash
  // Future<void> updateUser(UserModel updatedUser) async {
  //   try {
  //     await _firestore
  //         .collection('users')
  //         .doc(updatedUser.id)
  //         .update(updatedUser.toMap());
  //     _user = updatedUser;
  //     notifyListeners();
  //   } catch (e) {
  //     print("❌ Foydalanuvchini yangilashda xatolik: ${e.toString()}");
  //   }
  // }

  /// 🔹 Foydalanuvchini tizimdan chiqarish
  // void clearUser() {
  //   _user = null;
  //   notifyListeners();
  // }

  // 📌 Mijozni tanlangan sartaroshning navbatiga qo'shish
  Future<void> joinQueue(String barberId) async {
    try {
      String userId = _user!.id;

      final barberRef = _firestore.collection('barbers').doc(barberId);
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      // Sartarosh ma'lumotlarini olish
      final barberDoc = await barberRef.get();
      if (!barberDoc.exists) {
        debugPrint("Sartarosh topilmadi!");
        return;
      }
      // final List<Map<String,dynamic>> queue = barberDoc['queue'];


      // Mijozni `queue` ga qo'shish
      await barberRef.update({
        "queue": FieldValue.arrayUnion([
          {
            "userId": _user!.id,
            "username": _user!.fullName,
            "status": "waiting",
            "createdAt":DateTime.now()
          }
        ])
      });
      // 🔹 2. Mijoz hujjatiga `currentBarber` maydonini yozish
      await userRef.update({"currentBarber": barberId});

      // 🔹 3. UserModelni yangilash (Provider orqali)
      _user = _user!.copyWith(currentBarber: barberId);

      notifyListeners();

      debugPrint("Mijoz navbatga qo'shildi!");
      notifyListeners();
    } catch (e) {
      debugPrint("Navbatga qo'shishda xatolik: $e");
    }
  }

//--------------------------------------------------------------------------- foydalanuvchi uchun Navbat bo'limi--------------------------------------------------
  // FOydalanuvchi uchun navbat xolatini aniqlash
  int checkQueue(Map<String, dynamic> barber) {
// Sartaroshning navbati
    List<Map<String, dynamic>> queue =
        List<Map<String, dynamic>>.from(barber["queue"] ?? []);

    var customer =
        queue.firstWhere((c) => c["userId"] == user!.id, orElse: () => {});
    int queueposition =
        queue.indexWhere((element) => element['userId'] == user!.id);

    _queuePosition = queueposition;
    notifyListeners();
    return queueposition;
  }

// Navbatni o'chirish
  Future<void> cancelQueue(List<Map<String, dynamic>> queue) async {
    try {
// Firestoredan sartaroshni olish
      DocumentReference barberRef = FirebaseFirestore.instance
          .collection('barbers')
          .doc(_user!.currentBarber);

      queue.removeAt(_queuePosition!);
      // Firestoreni yangilash
      await barberRef.update({'queue': queue});
      notifyListeners();
    } catch (e) {
      throw "UserQueue O'chirishda Xatolik";
    }
  }

  // Qidiruv funksiyalari
// Barcha sartaroshlarni olish
  Future<void> fetchBarbers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('barbers').get();
      _barbers = snapshot.docs
          .map((doc) => BarberModel.fromMap(doc.data(), doc.id))
          .toList();
 
      notifyListeners();
    } catch (e) {
      print("❌ Sartaroshlarni olishda xatolik: $e");
    }
  }

  // Qidiruv funksiyasi
  void searchBarbers(String query) {
    if (query.isNotEmpty) {
      _filteredBarbers = _barbers
          .where((barber) =>
              barber.fullName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clearfilter() {
    _filteredBarbers = [];
    notifyListeners();
  }
}
