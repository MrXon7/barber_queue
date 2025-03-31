import 'package:flutter/material.dart';

class BarberServices extends StatelessWidget {
  const BarberServices({
    super.key,
    required this.services,
  });

  final List services;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(services[index]['sname'],
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 1)),
              subtitle: Text('Jarayon o\'rtacha ${services[index]['stime']} minut',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              trailing: Text(
                '${services[index]['sprice']} so\'m',
                style: TextStyle(color: Colors.amber, fontSize: 20),
              ),
            ),
          );
        });
  }
}
