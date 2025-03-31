import 'package:barber_queue/companents/user_companents/bPortfolioItem.dart';
import 'package:barber_queue/companents/user_companents/barberServices.dart';
import 'package:barber_queue/companents/user_companents/myfloatingActionButton.dart';
import 'package:barber_queue/companents/user_companents/socialIcons.dart';
import 'package:barber_queue/providers/userProvider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BarberForuserPage extends StatelessWidget {
  final String barberId;

  BarberForuserPage({super.key, required this.barberId});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: barberId.isEmpty
          ? Center(child: CircularProgressIndicator(color: Colors.amber))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('barbers')
                  .doc(barberId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.amber));
                }
                final barber = snapshot.data!.data() as Map<String, dynamic>;

                return Scaffold(
                  backgroundColor: Colors.black,
                  floatingActionButton: barber['isAvailable']
                      ? MyFloatingActionButton(
                          onPressed: () {
                            Provider.of<UserProvider>(context, listen: false)
                                .joinQueue(barberId);
                            userProvider.clearfilter();

                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                        )
                      : null,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  body: Center(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          leading: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ),
                          pinned: true,
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.5,
                          backgroundColor: Colors.black.withOpacity(1),
                          flexibleSpace: FlexibleSpaceBar(
                            // sartarosh profil rasmi
                            background: Container(
                              color: Colors.black.withOpacity(0),
                              child: Image.network(
                                barber['profileImage'] ??
                                    'https://ibb.co/DDdnYwbg',
                                fit: BoxFit.fill,
                              ), // Optional: Add a semi-transparent overlay
                            ),
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            List queuelen = barber['queue'];
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              color: Colors.black,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // status box
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: barber['isAvailable']
                                              ? Colors.green.withOpacity(0.3)
                                              : Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          barber['isAvailable']
                                              ? 'online'
                                              : 'offline',
                                          style: TextStyle(
                                              color: barber['isAvailable'] ==
                                                      'online'
                                                  ? Colors.green
                                                  : Colors.grey.shade500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Barber Name
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          barber['fullName'].toUpperCase(),
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 28,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${barber['rating']}",
                                        style: TextStyle(
                                            color: Colors.grey.shade100,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  // Location
                                  InkWell(
                                    onTap: () async {
                                      final String googleMapsUrl =
                                          barber['location'];
                                      if (await canLaunch(googleMapsUrl)) {
                                        await launch(googleMapsUrl);
                                      } else {
                                        throw 'URL ochilmadi: $googleMapsUrl';
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Sartarosh Manzili...',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),

                                  // rating
                                  Text("${queuelen.length} ta odam navbatda",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 18)),
                                  SizedBox(height: 20),
                                  // portfolio
                                  Text("Portfolio",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  barber['portfolio'] != null
                                      ? CarouselSlider(
                                          options: CarouselOptions(
                                              height: 200, autoPlay: true),
                                          items: barber['portfolio']
                                              .map<Widget>((url) {
                                            return BportfolioItem(
                                              url: url,
                                            );
                                          }).toList(),
                                        )
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          height: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade800,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              "Portfolio bo'sh",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                  SizedBox(height: 20),
                                  // services
                                  Text("Xizmatlar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  BarberServices(services: barber['services']),
                                  SizedBox(height: 20),

                                  // social icons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SocialIcons(
                                        url: [
                                          barber[
                                              'phoneNumber'], //'tel:+998944574775',
                                          barber[
                                              'telegram'], //'https://t.me/uzmujf2020',
                                          barber[
                                              'instagram'] //'https://www.instagram.com/alixonov_i/'
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 50),
                                ],
                              ),
                            );
                          },
                          childCount: 1,
                        ))
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
