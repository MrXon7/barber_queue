import 'package:barber_queue/companents/barber_companents/jarayondaListView.dart';
import 'package:barber_queue/companents/barber_companents/navbatListView.dart';
import 'package:barber_queue/pages/barber_pages/bsettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BarberHome extends StatefulWidget {
  const BarberHome({super.key});

  @override
  State<BarberHome> createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> {
  bool iswitched = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: MediaQuery.of(context).size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // myappbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Bsettings()));
                    },
                    icon: Icon(
                      Icons.person_2_rounded,
                      size: 28,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    "SALOM JANOB",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                  Switch(
                      activeColor: Colors.amber,
                      value: iswitched,
                      onChanged: (value) {
                        setState(() {
                          iswitched = value;
                        });
                      })
                ],
              ),
              // Main content
              Expanded(
                  child: iswitched
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            // hozzirda  jarayonda
                            Text(
                              "Navbati keldi: 4ta",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontFamily: 'RobotoCondensed'),
                            ),
                            SizedBox(height: 10),
                            // hozzirda  jarayonda
                            Jarayonda(),
                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Navbatda: 13ta",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontFamily: 'RobotoCondensed'),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Yangi Mijoz qo'shish",
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            // Navbatdagilar listview
                            Navbat(),
                          ],
                        )
                      : Center(
                          child: Text(
                            "Siz hozircha ishni boshlamadingiz",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
