import 'dart:async';
import 'package:barber_queue/models/barber.dart';
import 'package:barber_queue/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'dart:html' as html;


class AuthProvider with ChangeNotifier {
  String? _telegramId;
  UserModel? _userData;
  BarberModel? _barberData;
  bool _isLoading = true;
  bool _isConnected = false;

  String? get telegramId => _telegramId;
  UserModel? get userData => _userData;
  BarberModel? get barberData => _barberData;
  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;

  AuthProvider() {
    _getTelegramIdFromUrl();
    checkConnection();
  }

  void checkConnection() {
    InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          _isConnected = true;
          notifyListeners();
          break;
        case InternetStatus.disconnected:
          _isConnected = false;
          notifyListeners();
          break;
        default:
          _isConnected = false;
          notifyListeners();
      }
    });
  }

  void _getTelegramIdFromUrl() {
    // url orqali telegram id ni olish
     Uri uri = Uri.parse(html.window.location.href);
      _telegramId = uri.queryParameters['telegram_id'];

    // _telegramId = '5865675953';

    if (_telegramId != null) {
      _checkUserInFirestore(_telegramId!);
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _checkUserInFirestore(String telegramId) async {
    try {
      // sartarosh bazada mavjudmi?
      DocumentSnapshot barberDoc = await FirebaseFirestore.instance
          .collection('barbers')
          .doc(telegramId)
          .get();
      // foydalanuvchi bazada mavjudmi?
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(telegramId)
          .get();

      if (userDoc.exists) {
        // Foydalanuvchi mavjud bo'lsa
        _userData = UserModel.fromMap(
            userDoc.data() as Map<String, dynamic>, telegramId);
      } else if (barberDoc.exists) {
        _barberData = BarberModel.fromMap(
            barberDoc.data() as Map<String, dynamic>, telegramId);
        _userData = null;
      } else {
        _userData = null;
        _barberData = null;
      }
    } catch (e) {
      print("!!!Error checking user: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> registerUser(UserModel newUser, BuildContext contex) async {
    if (_telegramId == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(newUser.id)
        .set(newUser.toMap());

    _userData = newUser;
    notifyListeners();
  }

  Future<void> registerBarber(
      BarberModel newBarber, BuildContext contex) async {
    if (_telegramId == null) return;

    await FirebaseFirestore.instance
        .collection('barbers')
        .doc(newBarber.id)
        .set(newBarber.toMap());

    _barberData = newBarber;
    notifyListeners();
  }
}
