import 'package:flutter/material.dart';

class Jarayonda extends StatelessWidget {
  const Jarayonda({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: ListView.builder(
            itemCount: 3 ,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("Navbat raqami: 1",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              )),
                        ),
                        Expanded(
                          child: Text("Ismi: Alixonov Ismoilxon",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Text("Kechiktirish",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Yakunlash",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              );
            }));
  }
}
