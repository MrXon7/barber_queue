import 'package:barber_queue/companents/aboutBarberItem.dart';
import 'package:barber_queue/companents/userAppBar.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  UserHomePage({super.key});

  List barberList = [
    'barber1',
    'barber2',
    'barber3',
    'barber4',
    'barber1',
    'barber2',
    'barber3',
    'barber4'
  ];
  List holatlist = [
    "online",
    "offline",
    "offline",
    "online",
    "online",
    "offline",
    "offline",
    "online"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // myappbar
              UserAppBar(),
              SizedBox(height: 10),
              // Search bnt
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      border: Border.all(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.amber,
                        size: 32,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "SEARCH",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "Sartaroshlar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            mainAxisExtent: 267,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: barberList.length,
                        itemBuilder: (contex, index) {
                          return BarberItem(
                            barberList: barberList,
                            holatlist: holatlist,
                            index: index,
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
