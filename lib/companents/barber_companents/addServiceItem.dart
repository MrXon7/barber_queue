import 'package:barber_queue/providers/barberProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void ShowAddServiceDialog(BuildContext context, String field, String content) {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  final TextEditingController _timecontroller = TextEditingController();

  Future<void> addService() async {
    String sname = _namecontroller.text.trim();
    String stime = _timecontroller.text.trim();
    String pricetext = _pricecontroller.text.trim();

    if (sname.isEmpty || stime.isEmpty || pricetext.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Barcha maydonlarni to'ldiring!")),
      );
      return;
    }
    int? sprice = int.tryParse(pricetext);
    if (sprice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Narxni to'g'ri formatda kiriting!")),
      );
      return;
    }

    Map<String, dynamic> newService = {
      "sname": sname,
      "stime": stime,
      "sprice": sprice
    };

   await Provider.of<BarberProvider>(context, listen: false)
        .addServiceToBarber(field, newService);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Xizmat qo'shildi!")),
    );

    // Maydonlarni tozalash
    _namecontroller.clear();
    _timecontroller.clear();
    _pricecontroller.clear();
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          content,
          style: TextStyle(color: Colors.white),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Xizmat nomi
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    labelText: 'Xizmat nomini kiriting',
                  ),
                ),
                // Xizmat narxi
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _pricecontroller,
                  decoration: InputDecoration(
                    labelText: 'Xizmat narxini kiriting',
                  ),
                ),
                // Xizmat ko'rsatish vaqti
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _timecontroller,
                  decoration: InputDecoration(
                    labelText: 'Xizmat vaqtini kiriting',
                  ),
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Bekor QIlish',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  addService();
                  Navigator.pop(context);
                },
              ),
        ],
      );
    },
  );
}
