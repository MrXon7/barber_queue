import 'package:barber_queue/pages/barber_pages/aboutBarber.dart';
import 'package:barber_queue/pages/barber_pages/addservices.dart';
import 'package:barber_queue/pages/barber_pages/portfolio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Bsettings extends StatelessWidget {
  Bsettings({super.key});

  List Bdata = [
    [
      "Shaxsiy ma'lumotlar",
      "Shaxsiy ma'lumotlaringizni o'zgartiring",
      Aboutbarber()
    ],
    ["Portfolio", "Ish namunalaringizni qo'shing", PortfolioPage()],
    ["Xizmatlar", "Ko'rsatadigan xizmatlaringizni qo'shing", Barber_Services()],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            foregroundColor: Colors.amber,
            backgroundColor: Colors.black,
            centerTitle: true,
            shadowColor: Colors.grey,
            elevation: 1,
            title: Text("ACCOUNT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2))),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListView.builder(
                itemCount: Bdata.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(Bdata[index][0],
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      Bdata[index][1],
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                          letterSpacing: 1),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.amber,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bdata[index][2]));
                    },
                  );
                })),
      ),
    );
  }
}
