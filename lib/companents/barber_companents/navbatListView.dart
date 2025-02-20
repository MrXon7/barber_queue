import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Navbat extends StatelessWidget {
  const Navbat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView.builder(
          itemCount: 13,
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
                      onPressed: (context) {},
                      icon: Icons.check_box_rounded,
                      label: 'Boshlash',
                      backgroundColor: Colors.green,
                    ),
                    SlidableAction(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      onPressed: (context) {},
                      icon: Icons.delete,
                      label: 'O\'chirish',
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text("Navbat raqami: $index",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      )),
                  subtitle: Text("Ismi: Ali",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      )),
                ),
              ),
            );
          }),
    );
  }
}
