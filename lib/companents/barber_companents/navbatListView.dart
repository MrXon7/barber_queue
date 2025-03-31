import 'package:barber_queue/providers/barberProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class Navbat extends StatelessWidget {
  List<Map<String, dynamic>> queue;
  Navbat({super.key, required this.queue});

  @override
  Widget build(BuildContext context) {
    return queue.length == 0
        ? Expanded(
            child: Center(
              child: Text(
                "Navbat yo'q",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        : Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount: queue.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Provider.of<BarberProvider>(context,
                                      listen: false)
                                  .startService(queue[index]['userId']);
                            },
                            icon: Icons.check_box_rounded,
                            label: 'Boshlash',
                            backgroundColor: Colors.green,
                          ),
                          SlidableAction(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            onPressed: (context) {
                              Provider.of<BarberProvider>(context,
                                      listen: false)
                                  .completeService(queue[index]['userId']);
                            },
                            icon: Icons.delete,
                            label: 'O\'chirish',
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text("Navbat raqami: ${index + 2}",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            )),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ismi: ${queue[index]['username']}",
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                )),
                            Text("Xizmat: Jarayonda aniqlanadi",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}
