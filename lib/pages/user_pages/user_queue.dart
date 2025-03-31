import 'package:barber_queue/companents/user_companents/socialIcons.dart';
import 'package:barber_queue/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserQueue extends StatelessWidget {
  final barber;

  const UserQueue({super.key, required this.barber});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String userId = userProvider.user!.id;

// Sartaroshning navbati
    List<Map<String, dynamic>> queue =
        List<Map<String, dynamic>>.from(barber['queue']);

    var customer =
        queue.firstWhere((c) => c["userId"] == userId, orElse: () => {});

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Siz Navbatdasiz'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: customer['status'] == 'waiting'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 370,
                          width: 300,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${(userProvider.queuePosition)! + 1}",
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 72,
                                    ),
                                  ),
                                  Text('Navbat raqami',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Sartarosh:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)),
                                      Text(barber['fullName'],
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Taxminiy kutish vaqti:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)),
                                      Text(
                                          '${(userProvider.queuePosition)!*20} minut',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Aloqa uchun",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      SizedBox(width: 10),
                                      // social icons
                                      Expanded(
                                        child: SocialIcons(
                                          url: [
                                            barber[
                                                'phoneNumber'], //'tel:+998944574775',
                                            barber[
                                                'telegram'], //'https://t.me/uzmujf2020',
                                            barber[
                                                'instagram'] //'https://www.instagram.com/alixonov_i/'
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext contex) {
                                        return AlertDialog(
                                          backgroundColor: Colors.grey.shade800,
                                          title: Text("Diqqqat!!!",
                                              style: TextStyle(
                                                  letterSpacing: 2,
                                                  color: Colors.amber,
                                                  fontSize: 20)),
                                          content: Text(
                                              "Siz navbatdan chiqib ketyabsiz.\nHali ham shu fikirdamisiz?",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Bekor qilish",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  await userProvider
                                                      .cancelQueue(queue);
                                                },
                                                child: Text('Ok',
                                                    style: TextStyle(
                                                        color: Colors.white)))
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "Navbatni Bekor qilish",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Diqqat!!!. Hurmatli mijoz navbatingiz kelgan vaqtda sartaroshxonada bo'lishingiz kerak."
                          "Sararoshxonaga yetib kelmagan taqdiringizda navbatingiz bekor qilinadi",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, letterSpacing: 1),
                        ),
                      ],
                    )
                  : customer['status'] == 'inProgress'
                      ? Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/congratulations.png'),
                                fit: BoxFit.contain),
                          ),
                        )
                      : Center(
                          child: Text(
                            "Raning page",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))),
    );
  }
}
