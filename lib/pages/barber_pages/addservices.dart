import 'package:barber_queue/companents/barber_companents/addServiceItem.dart';
import 'package:barber_queue/providers/barberProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class Barber_Services extends StatelessWidget {
  const Barber_Services({super.key});

  @override
  Widget build(BuildContext context) {
    var barberProvider = Provider.of<BarberProvider>(context);

    if (barberProvider.barber == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var barber = barberProvider.barber!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          foregroundColor: Colors.amber,
          backgroundColor: Colors.black,
          centerTitle: true,
          shadowColor: Colors.grey,
          elevation: 1,
          title: Text("Xizmatlar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: barber.services.length,
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
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        onPressed: (context) {
                          Provider.of<BarberProvider>(context, listen: false)
                              .deleteServiceByIndex(index);
                        },
                        icon: Icons.delete,
                        label: 'O\'chirish',
                        backgroundColor: Colors.red,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title:
                        Text("Xizmat Nomi: ${barber.services[index]['sname']}",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            )),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Narxi: ${barber.services[index]['sprice']}",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            )),
                        Text("Vaqti: ${barber.services[index]['stime']}",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          ShowAddServiceDialog(context, 'services', "Yangi Xizmat qo'shish");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
