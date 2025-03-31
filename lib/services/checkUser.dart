import 'package:barber_queue/pages/barber_pages/barberHomePage.dart';
import 'package:barber_queue/pages/signup_page.dart';
import 'package:barber_queue/pages/user_pages/user_home_page.dart';
import 'package:barber_queue/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isLoading) {
      return Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: CircularProgressIndicator(color: Colors.amber)));
    }

    if (authProvider.userData == null && authProvider.barberData == null) {
      return SingupPage();
    }

     return  authProvider.userData == null ? BarberHome(barberId: authProvider.telegramId!,) : UserHomePage();
  
  }
}
