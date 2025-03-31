import 'package:barber_queue/providers/barberProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Jarayonda extends StatelessWidget {
  List<Map<String, dynamic>> current;
  Jarayonda({
    required this.current,
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    return current.length == 0
        ? Expanded(
            child: Center(
              child: Text(
                "Mijoz yo'q",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        : Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: current.length,
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
                              child: Text("Ismi: ${current[index]['username']}",
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
                              child: Text("Xizmat: Jarayonda aniqlanadi",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  )),
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
                                  onPressed: () {
                                    Provider.of<BarberProvider>(context,
                                            listen: false)
                                        .completeCustomerService(current[index]['userId']);
                                    print(current);
                                  },
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
