import 'package:barber_queue/companents/barber_companents/showInputDialog.dart';
import 'package:barber_queue/providers/barberProvider.dart';
import 'package:barber_queue/providers/imgProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Aboutbarber extends StatelessWidget {
  const Aboutbarber({super.key});

  @override
  Widget build(BuildContext context) {
    var barberProvider = Provider.of<BarberProvider>(context);

    if (barberProvider.barber == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var barber = barberProvider.barber!;

    final imgprovider = Provider.of<Imgprovider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.amber,
                        )),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    await imgprovider.uploadImage();
                    if (imgprovider.Image!.imageUrl != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Rasm muvaffaqiyatli yuklandi"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,
                      ));
                      await barberProvider.updateBarberData(
                          'profileImage', imgprovider.Image!.imageUrl!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Rasm yuklanmadi"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.network(
                        height: 200,
                        barber.profileImage ?? "",
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              barber.fullName[0].toUpperCase(),
                              style: TextStyle(
                                  fontSize: 72, fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade800,
                  thickness: 1,
                ),
                // ism List tile
                ShaxsiyListTile(
                    onTap: () {
                      ShowInputDialog(
                          context, 'fullName', "Ism Familiya ni kiriting");
                    },
                    icon: Icons.person,
                    title: "Ism Familiya",
                    subtitle: barber.fullName),
                // Telefon raqami
                ShaxsiyListTile(
                    onTap: () {
                      ShowInputDialog(
                          context, 'phoneNumber', "Telefon raqamni kiriting");
                    },
                    icon: Icons.call,
                    title: "Telefon raqam",
                    subtitle: barber.phoneNumber),
                // Instagram
                ShaxsiyListTile(
                    onTap: () {
                      ShowInputDialog(context, 'instagram',
                          "Instagram username ni kiriting");
                    },
                    icon: FontAwesomeIcons.instagram,
                    title: "Instagram",
                    subtitle: barber.instagram!),
                // Telegram
                ShaxsiyListTile(
                    onTap: () {
                      ShowInputDialog(
                          context, 'telegram', "Telegram username ni kiriting");
                    },
                    icon: Icons.telegram,
                    title: "Telegram",
                    subtitle: barber.telegram!),
                // Manzil
                ShaxsiyListTile(
                    onTap: () {
                      ShowInputDialog(context, 'location', "Manzilni kiriting");
                    },
                    icon: Icons.location_on,
                    title: "Manzil",
                    subtitle: barber.location!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShaxsiyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final void Function() onTap;
  const ShaxsiyListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.amber,
      ),
      title: Text(title,
          style: TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
      trailing: Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
