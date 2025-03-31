import 'package:barber_queue/models/barber.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarberProvider with ChangeNotifier {
  BarberModel? _barber;

  BarberModel? get barber => _barber;

  // 🔹 Firestore dan sartarosh ma’lumotlarini yuklash
  Future<void> fetchBarberData(String telegramId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("barbers")
          .doc(telegramId)
          .get();

      if (doc.exists) {
        _barber =
            BarberModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        notifyListeners();
      }
    } catch (e) {
      print("Xatolik: $e");
    }
  }

  Stream<DocumentSnapshot> getBarberStream(String barberId) {
    final data = FirebaseFirestore.instance
        .collection('barbers')
        .doc(barberId)
        .snapshots();
       data.listen((snapshot) {
      if (snapshot.exists) {
        _barber = BarberModel.fromMap(
            snapshot.data() as Map<String, dynamic>, snapshot.id);
        notifyListeners();
      }
    });
    return data;
  }

  // 🔹 Ma’lumotlarni yangilash
  Future<void> updateBarberData(String field, dynamic newValue) async {
    if (_barber == null) return;
    String userId = _barber!.id;

    try {
      await FirebaseFirestore.instance
          .collection("barbers")
          .doc(userId)
          .update({field: newValue});

      // 🔹 Modelni yangilaymiz isChecked
      _barber = BarberModel(
          id: _barber!.id,
          fullName: field == 'fullName' ? newValue : _barber!.fullName,
          phoneNumber: field == 'phoneNumber' ? newValue : _barber!.phoneNumber,
          instagram: field == 'instagram' ? newValue : _barber!.instagram,
          telegram: field == 'telegram' ? newValue : _barber!.telegram,
          isAvailable: field == 'isAvailable' ? newValue : _barber!.isAvailable,
          isChecked: field == 'isChecked' ? newValue : _barber!.isChecked,
          location: field == 'location' ? newValue : _barber!.location,
          services: field == 'services' ? newValue : _barber!.services,
          queue: field == 'queue' ? newValue : _barber!.queue,
          rating: field == 'rating' ? newValue : _barber!.rating,
          createdAt: field == 'createdAt' ? newValue : _barber!.createdAt,
          profileImage:
              field == 'profileImage' ? newValue : _barber!.profileImage,
          portfolio: field == 'portfolio' ? newValue : _barber!.portfolio);
      notifyListeners();
    } catch (e) {
      print("Updateda Xatolik: $e");
    }
  }

// ---------------------------------------------------------------Xizmatlarni qo'shib o'chirish-----------------------------------------
  // Xizmat qo'shish
  Future<void> addServiceToBarber(
      String field, Map<String, dynamic> newValue) async {
    // Barber Modelni yangilash
    _barber = BarberModel(
      id: _barber!.id,
      fullName: _barber!.fullName,
      phoneNumber: _barber!.phoneNumber,
      instagram: _barber!.instagram,
      telegram: _barber!.telegram,
      isAvailable: _barber!.isAvailable,
      isChecked: _barber!.isChecked,
      location: _barber!.location,
      services: field == 'services'
          ? [..._barber!.services, newValue]
          : _barber!.services,
      queue: _barber!.queue,
      rating: _barber!.rating,
      createdAt: _barber!.createdAt,
      profileImage: _barber!.profileImage,
      portfolio: _barber!.portfolio,
    );
    // await updateBarberData('services', FieldValue.arrayUnion([newValue]));
    await FirebaseFirestore.instance
        .collection("barbers")
        .doc(_barber!.id)
        .update({
      "services": FieldValue.arrayUnion(
          [newValue]) // Avvalgi ma'lumotlar saqlanadi, faqat yangi qo'shiladi
    });

    notifyListeners();
  }

  // Xizmatni o'chirish
  Future<void> deleteServiceByIndex(int index) async {
    if (_barber == null) return;

    // Yangi xizmatlar ro‘yxati (tanlangan indeksdagi xizmat o‘chiriladi)
    List<Map<String, dynamic>> updatedServices =
        List.from(_barber!.services ?? []);
    updatedServices.removeAt(index);
    //  Ma'lumotlarni yangilash
    await updateBarberData('services', updatedServices);
  }

  //-----------------------------------------------------------------Navbatni Boshqarish bo'limi-----------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------
// Navbatni keyingisiga o'tkazish
  Future<void> completeCustomerService(String customerId) async {
    if (_barber == null) return; // Barber mavjudligini tekshiramiz

    List<Map<String, dynamic>> updatedQueue = List.from(_barber!.queue ?? []);

    // 🔹 Mijozni topib, statusini "completed" ga o'zgartiramiz
    // int index = updatedQueue.indexWhere((q) => q['userId'] == customerId);
    updatedQueue.removeWhere((q) => q['userId'] == customerId);
    // 🔹 Agar keyingi mijoz bo‘lsa, uni "in_progress" qilish
    if (updatedQueue.length >= 1 && updatedQueue[0]['status'] != 'completed') {
      updatedQueue[0]['status'] = 'inProgress';
    }
// Ma'lumotlarni yangilash
    await updateBarberData('queue', updatedQueue);
  }

  // 🔹 Foydalanuvchi ID bo‘lmagan holda faqat ismi bilan qo‘shish
  Future<void> addCustomerWithoutId(String barberId, String userName) async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final barberRef = _firestore.collection('barbers').doc(barberId);

      await barberRef.update({
        "queue": FieldValue.arrayUnion([
          {
            "userId": userName,
            "username": userName,
            "status": "waiting",
            "createdAt": DateTime.now()
          }
        ])
      });
      fetchBarberData(barberId);
      notifyListeners();
    } catch (e) {
      print("Xatolik: $e");
    }
  }
  // Removed invalid call

//--------------------------------------------------------------- Navbat bo'limidagi Slidable tugmalari funksiyalari

  /// 🔹 Ishni boshlash (status: `inProgress`)
  void startService(String customerId) async {
    if (_barber == null) return;

    List<Map<String, dynamic>> updatedQueue = _barber!.queue.map((customer) {
      if (customer['userId'] == customerId) {
        return {...customer, 'status': 'inProgress'};
      }
      return customer;
    }).toList();
    // ma'lumotlarni yangilash
    await updateBarberData('queue', updatedQueue);
  }

  /// 🔹 Tugatish (mijozni navbatdan o‘chirish va keyingisini boshlash)
  void completeService(String customerId) async {
    if (_barber == null) return;

    List<Map<String, dynamic>> updatedQueue = _barber!.queue
        .where((customer) => customer['userId'] != customerId)
        .toList();
    // ma'lumotlarni yangilash
    await updateBarberData('queue', updatedQueue);
  }

  // portfolioga rasm yuklash
  // Xizmat qo'shish
  Future<void> addPorfolioToBarber(
      String field, Map<String, dynamic> newValue) async {
    // Barber Modelni yangilash
    _barber = BarberModel(
      id: _barber!.id,
      fullName: _barber!.fullName,
      phoneNumber: _barber!.phoneNumber,
      instagram: _barber!.instagram,
      telegram: _barber!.telegram,
      isAvailable: _barber!.isAvailable,
      isChecked: _barber!.isChecked,
      location: _barber!.location,
      services: _barber!.services,
      queue: _barber!.queue,
      rating: _barber!.rating,
      createdAt: _barber!.createdAt,
      profileImage: _barber!.profileImage,
      portfolio: field == 'portfolio'
          ? [..._barber!.portfolio ?? [], newValue]
          : _barber!.portfolio,
    );
    await FirebaseFirestore.instance
        .collection("barbers")
        .doc(_barber!.id)
        .update({
      "portfolio": FieldValue.arrayUnion(
          [newValue]) // Avvalgi ma'lumotlar saqlanadi, faqat yangi qo'shiladi
    });
    notifyListeners();
  }

// Portfolio rasmini o'chirish
  Future<void> deletePortfolioByIndex(int index) async {
    try {
      if (_barber == null) return;

      // Yangi xizmatlar ro‘yxati (tanlangan indeksdagi xizmat o‘chiriladi)
      List<Map<String, dynamic>> updatedPic =
          List.from(_barber!.portfolio ?? []);
      updatedPic.removeAt(index);
      //  Ma'lumotlarni yangilash
      await updateBarberData('portfolio', updatedPic);
      notifyListeners();
      print("Rasm o'chirildi");
    } catch (e) {
      print("Rasm o'chirishda xatolik $e");
    }
  }
}
