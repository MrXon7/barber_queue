import 'package:flutter/material.dart';

class BarberServices extends StatelessWidget {
  const BarberServices({
    super.key,
    required this.services,
  });

  final List<List<String>> services;

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
              title: Text(services[index][0],
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 1)),
              subtitle: Text('Jarayon o\'rtacha ${services[index][1]} minut',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              trailing: Text(
                '${services[index][2]} so\'m',
                style: TextStyle(color: Colors.amber, fontSize: 20),
              ),
            ),
          );
        });
  }
}
