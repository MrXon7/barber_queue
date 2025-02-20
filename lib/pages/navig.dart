import 'package:barber_queue/pages/barber_pages/barberHomePage.dart';
import 'package:barber_queue/pages/user_pages/user_home_page.dart';
import 'package:flutter/material.dart';

class Navig extends StatelessWidget {
  const Navig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserHomePage()));
                  },
                  child: Text("User")),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BarberHome()));
                  },
                  child: Text("Barber")),
            ],
          ),
        ),
      );
  }
}