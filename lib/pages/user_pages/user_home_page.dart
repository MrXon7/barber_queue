import 'package:barber_queue/companents/user_companents/aboutBarberItem.dart';
import 'package:barber_queue/companents/user_companents/userAppBar.dart';
import 'package:barber_queue/pages/user_pages/searchpage.dart';
import 'package:barber_queue/pages/user_pages/user_queue.dart';
import 'package:barber_queue/providers/authProvider.dart';
import 'package:barber_queue/providers/userProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatelessWidget {
  UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    //  Foydalanuvchi ma'lumotlarini yukalsh
    userProvider.fetchUser(authProvider.telegramId!);
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Consumer<UserProvider>(builder: (contex, userprovider, child) {
          final user = userprovider.user;

          if (user == null) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            )); // Ma'lumot yuklanayotgan paytda
          }
          return Scaffold(
              backgroundColor: Colors.black,
              appBar: UserAppBar(username: userProvider.user!.fullName),
              body: authProvider.isConnected
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('barbers')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.amber,
                          ));
                        }

                        var barbers = snapshot.data!.docs;

                        // kerakli sartaroshni id bo'yicha topish, Navbatni kuzatish uchun kerak bo'ladi
                        String currntBarber = user.currentBarber!;

                        if (currntBarber.isEmpty) {
                          return BarbersForUser(barbers: barbers);
                        }

                        var selectedBarber = barbers.firstWhere(
                            (barber) => barber.id == currntBarber,
                            orElse: () => null!);


                        int chek = selectedBarber == null
                            ? -1
                            : userprovider.checkQueue(
                                selectedBarber.data() as Map<String, dynamic>);
                        return chek >= 0
                            ? UserQueue(barber: selectedBarber)
                            : barbers.length < 1
                                ? Center(
                                    child: Text(
                                        "Sartaroshlar ro'yxati topilmadi",
                                        style: TextStyle(color: Colors.white)),
                                  )
                                : BarbersForUser(barbers: barbers);
                      })
                  : Center(
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
                    ));
        }),
      ),
    );
  }
}

class BarbersForUser extends StatelessWidget {
  const BarbersForUser({
    super.key,
    required this.barbers,
  });

  final List<QueryDocumentSnapshot<Object?>> barbers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10),
          // Search bnt
          GestureDetector(
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage()));
            },
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
                    itemCount: barbers.length,
                    itemBuilder: (contex, index) {
                      final barber =
                          barbers[index].data() as Map<String, dynamic>;
                      String barberId = barbers[index].id;
                      return BarberItem(
                        barber: barber,
                        barberId: barberId,
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
