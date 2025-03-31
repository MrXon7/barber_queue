import 'dart:ui';

import 'package:barber_queue/companents/user_companents/MyTextFormField.dart';
import 'package:barber_queue/models/barber.dart';
import 'package:barber_queue/models/user.dart';
import 'package:barber_queue/pages/barber_pages/barberHomePage.dart';
import 'package:barber_queue/pages/user_pages/user_home_page.dart';
import 'package:barber_queue/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SingupPage extends StatelessWidget {
  SingupPage({super.key});
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _phoneNumber;
  String? _selectedOption;

  String? _validatePhoneNumber(String? value) {
    final pattern = r'^\+998[0-9]{9}$';
    final regExp = RegExp(pattern);
    String newvalue = "+998${value!}";
    // ignore: unnecessary_null_comparison
    if (newvalue == null || newvalue.isEmpty) {
      return "Telefon raqamni kiriting";
    } else if (!regExp.hasMatch(newvalue)) {
      return "Iltimos,  raqamni to'g'ri kiriting";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    void _registerUser() async {
      try {
        final newUser = UserModel(
            id: authProvider.telegramId!,
            fullName: _name!,
            phoneNumber: _phoneNumber!,
            currentBarber: '',
            createdAt: DateTime.now());

        final newBarber = BarberModel(
            id: authProvider.telegramId!,
            fullName: _name!,
            phoneNumber: _phoneNumber!,
            instagram: "alixonov_i",
            telegram: "maktab58_tadbirlar",
            isAvailable: false,
            isChecked: false,
            services: [
              // {'sname': "Soch olish", "stime": "20", "sprice": '30000'}
            ],
            queue: [
              // {
              //   'userId': '1',
              //   'username': 'ali',
              //   'status': 'waiting',
              //   'createdAt': ''
              // },
              // {
              //   'userId': '2',
              //   'username': 'vali',
              //   'status': 'waiting',
              //   'createdAt': ''
              // },
              // {
              //   'userId': '3',
              //   'username': 'bashr',
              //   'status': 'waiting',
              //   'createdAt': ''
              // },
            ],
            location: "Kiritilmagan",
            rating: 5,
            createdAt: DateTime.now(),
            );
        // foydalanuvchilarni turiga qarab alohida saqlash
        if (_selectedOption == 'barber') {
          await authProvider.registerBarber(newBarber, context);
        } else {
          await authProvider.registerUser(newUser, context);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                _selectedOption == 'barber' ? BarberHome(barberId: authProvider.telegramId!,) : UserHomePage(),
          ),
        );
      } catch (e) {}
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/sign_page.png'),
                  fit: BoxFit.contain),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ro'yxatdan o'tish",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            myTextFormField(
                              label: "To'liq ism",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Iltimos, ismingizni kiriting";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _name = value;
                              },
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 40),
                            myTextFormField(
                              label: "Telefon raqam",
                              prefix: Text(
                                "+998 ",
                                style: TextStyle(color: Colors.white),
                              ),
                              validator: _validatePhoneNumber,
                              onSaved: (value) {
                                String newvalue = "+998${value!}";
                                _phoneNumber = newvalue;
                              },
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 40),
                            DropdownButtonFormField(
                                value: _selectedOption,
                                validator: (value) {
                                  if (value == null) {
                                    return "iltimos, variantlardan birini tanlang";
                                  }
                                  return null;
                                },
                                iconEnabledColor: Colors.white,
                                dropdownColor: Colors.black.withOpacity(0.5),
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    label: Text(
                                      "Rolingiz",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )),
                                items: [
                                  DropdownMenuItem(
                                      value: "client",
                                      child: Text("Mijoz",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                  DropdownMenuItem(
                                      value: "barber",
                                      child: Text(
                                        "Sartarosh",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                                onChanged: (value) => _selectedOption = value!),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 40),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Ma\'lumotlar saqlandi')));
                                  _registerUser();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Keyngi",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 2),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
