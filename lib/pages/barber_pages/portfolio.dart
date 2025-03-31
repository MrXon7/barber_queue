import 'package:barber_queue/models/barber.dart';
import 'package:barber_queue/providers/barberProvider.dart';
import 'package:barber_queue/providers/imgProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final barberProvider = Provider.of<BarberProvider>(context);
    final imgprovider = Provider.of<Imgprovider>(context);
    List<Map<String, dynamic>> portfolioImgs =
        barberProvider.barber!.portfolio ?? [];
    final BarberModel barber = barberProvider.barber!;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          foregroundColor: Colors.amber,
          backgroundColor: Colors.black,
          centerTitle: true,
          shadowColor: Colors.grey,
          elevation: 1,
          title: Text("Portfolio",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2))),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: portfolioImgs.isNotEmpty
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 150,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                shrinkWrap: true,
                itemCount: barber.portfolio!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey.shade800,
                              title: Text("Rasmni o'chirish",
                                  style: TextStyle(color: Colors.amber)),
                              content: Text("Rasmni o'chirmoqchimisiz?", style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Bekor qilish",style: TextStyle(color: Colors.white))),
                                TextButton(
                                    onPressed: () async {
                                      // print("DELETE ${barber.portfolio![index]['delete_url']}");
                                      // await imgprovider.deleteImage(barber.portfolio![index]['delete_url']);
                                      await barberProvider.deletePortfolioByIndex(index);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ha",style: TextStyle(color: Colors.white))),
                              ],
                            );
                          });
                      
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(
                          barber.portfolio![index]['url'],
                          fit: BoxFit.cover,
                        )),
                  );
                })
            : Center(
                child: Text("Portfolio bo'sh",
                    style: TextStyle(color: Colors.amber))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await imgprovider.uploadImage();
          if (imgprovider.Image!.imageUrl != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Rasm muvaffaqiyatli yuklandi"),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ));
            await barberProvider.addPorfolioToBarber(
                'portfolio', imgprovider.Image!.toJson());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Rasm yuklanmadi"),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
            ));
          }
        },
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }
}
