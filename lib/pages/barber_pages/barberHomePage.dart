import 'package:barber_queue/companents/barber_companents/jarayondaListView.dart';
import 'package:barber_queue/companents/barber_companents/navbatListView.dart';
import 'package:barber_queue/companents/user_companents/socialIcon.dart';
import 'package:barber_queue/companents/user_companents/socialIcons.dart';
import 'package:barber_queue/models/barber.dart';
import 'package:barber_queue/pages/barber_pages/bsettings.dart';
import 'package:barber_queue/providers/authProvider.dart';
import 'package:barber_queue/providers/barberProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BarberHome extends StatefulWidget {
  final String barberId;
  BarberHome({super.key, required this.barberId});

  @override
  State<BarberHome> createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<BarberProvider>(context, listen: false)
        .fetchBarberData(widget.barberId);
  }

  @override
  Widget build(BuildContext context) {
    var barberProvider = Provider.of<BarberProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    if (barberProvider.barber == null) {
      return Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: CircularProgressIndicator(color: Colors.amber)));
    }

    final barber = barberProvider.barber!;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: !authProvider.isConnected
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi,
                        color: Colors.amber,
                      ),
                      Text(
                        "Intenrnetga Ulanmagansiz!!!",
                        style: TextStyle(color: Colors.amber),
                      ),
                    ],
                  ),
                )
              : barber.isChecked
                  ? Padding(
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Bsettings()));
                                },
                                icon: Icon(
                                  Icons.person_2_rounded,
                                  size: 28,
                                  color: Colors.amber,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "SALOM ${barber.fullName}".toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                  activeColor: Colors.amber,
                                  value: barber.isAvailable,
                                  onChanged: (value) {
                                    barberProvider.updateBarberData(
                                        'isAvailable', value);
                                    // barberProvider.toggleAvailability(value);
                                  })
                            ],
                          ),
                          // Main content
                          Expanded(
                              child: barber.isAvailable ||
                                      barber.queue.isNotEmpty
                                  ? StreamBuilder<DocumentSnapshot>(
                                      stream: barberProvider.getBarberStream(barber.id),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.amber,
                                            ),
                                          );
                                        }
                                        
                                        final currentCustomer = barber.queue
                                            .where((index) =>
                                                index['status'] == "inProgress")
                                            .toList();
                                        final newqueue = barber.queue
                                            .where(
                                                (q) => q['status'] == "waiting")
                                            .toList();
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20),
                                            // hozzirda  jarayonda
                                            Text(
                                              "Navbati keldi: ${currentCustomer.length}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 2,
                                                  fontFamily:
                                                      'RobotoCondensed'),
                                            ),
                                            SizedBox(height: 10),
                                            // hozzirda  jarayonda
                                            Jarayonda(
                                              current: currentCustomer,
                                            ),
                                            SizedBox(height: 20),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Navbatda: ${newqueue.length}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 2,
                                                      fontFamily:
                                                          'RobotoCondensed'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        TextEditingController
                                                            _nameController =
                                                            TextEditingController();
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.grey
                                                                  .shade800,
                                                          title: Text(
                                                              "Yangi Mijoz qo'shish",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          content: TextField(
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            controller:
                                                                _nameController,
                                                            decoration: InputDecoration(
                                                                labelText:
                                                                    'foydalanuvchi ismi',
                                                                labelStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500)),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                if (_nameController
                                                                    .text
                                                                    .isNotEmpty) {
                                                                  barberProvider.addCustomerWithoutId(
                                                                      barber.id,
                                                                      _nameController
                                                                          .text);
                                                                  _nameController
                                                                      .clear();
                                                                  Navigator.pop(
                                                                      context); // 🔹 Dialogni yopish
                                                                }
                                                              },
                                                              child: Text(
                                                                "Qo'shish",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    "Yangi Mijoz qo'shish",
                                                    style: TextStyle(
                                                        color: Colors.amber),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            // Navbatdagilar listview
                                            Navbat(queue: newqueue),
                                          ],
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        "Siz hozircha ishni boshlamadingiz",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ))
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${barber.fullName} siz aktivlashtirilmagansiz. Aktivlashtirish uchun admin bilan quyidagi manzillar orqali bog'laning",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialIcon(
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                color: Colors.green,
                                onPressed: () => launch("tel:+998944574775"),
                              ),
                              SocialIcon(
                                icon: Icon(
                                  Icons.telegram,
                                  color: Colors.blue,
                                ),
                                onPressed: () =>
                                    launch("https://t.me/alixonov_i"),
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
    );
  }
}
