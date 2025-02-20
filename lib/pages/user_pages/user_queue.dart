import 'package:flutter/material.dart';

class UserQueue extends StatelessWidget {
  const UserQueue({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> queue = [
      "22", //Navbat raqami
      "0", //Navbatgacha odamlar soni
      "Richard Barber", //Sartarosh
      "30" //Taxminiy kutish vaqti
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Navbat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: queue.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sizda kutilayotgan navbat yoq",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "Asosiy sahifadan navbatga qo'shiling",
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12),
                      ),
                    ],
                  )
                : queue[1] != '0'
                    ? Container(
                        height: 350,
                        width: 300,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                  queue[0],
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
                                    Text('Navbatgacha odamlar soni:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    Text(queue[1],
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
                                    Text('Sartarosh:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    Text(queue[2],
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
                                            color: Colors.white, fontSize: 18)),
                                    Text('${queue[3]} minut',
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 18,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {},
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
                      )
                    : Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/congratulations.png'),
                              fit: BoxFit.contain),
                        ),
                      )),
      ),
    );
  }
}
