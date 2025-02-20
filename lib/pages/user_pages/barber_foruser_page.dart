import 'package:barber_queue/companents/bPortfolioItem.dart';
import 'package:barber_queue/companents/barberServices.dart';
import 'package:barber_queue/companents/myfloatingActionButton.dart';
import 'package:barber_queue/companents/socialIcons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BarberForuserPage extends StatelessWidget {
  final String img;
  final String holat;
  BarberForuserPage({super.key, required this.img, required this.holat});

  final List<String> imgList = [
    'assets/images/hair4.jpg',
    'assets/images/hair5.jpg',
    'assets/images/hair6.jpg',
  ];

  final List<List<String>> services = [
    ['Soch olish', '30', '10 000'],
    ['Soqol olish', '20', '7 000'],
    ['Bosh yuvish', '5', '5 000'],
    ['Soch Bo\'yash', '25', '15 000'],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: MyFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                expandedHeight: MediaQuery.of(context).size.height * 0.37,
                backgroundColor: Colors.black.withOpacity(1),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.black.withOpacity(0),
                    child: Image.asset(
                      'assets/images/$img.jpg',
                      fit: BoxFit.cover,
                    ), // Optional: Add a semi-transparent overlay
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                                color: holat == 'online'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                holat,
                                style: TextStyle(
                                    color: holat == 'online'
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
                            Text(
                              "richard $img".toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
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
                              "${1 + 2.5}",
                              style: TextStyle(
                                  color: Colors.grey.shade100, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        // Location
                        InkWell(
                          onTap: () async {
                            final String googleMapsUrl =
                                "https://maps.app.goo.gl/aRKe8qZMFA567aRPA";
                            if (await canLaunch(googleMapsUrl)) {
                              await launch(googleMapsUrl);
                            } else {
                              throw 'URL ochilmadi: $googleMapsUrl';
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.amber,
                                size: 16,
                              ),
                              Expanded(
                                child: Text(
                                  'Saroy MFY, Namangan ko\'cha nechinchidir uy',
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
                        Text("43 ta odam navbatda",
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 18)),
                        SizedBox(height: 20),
                        // portfolio
                        Text("Portfolio",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CarouselSlider(
                          options: CarouselOptions(height: 200, autoPlay: true),
                          items: imgList.map((url) {
                            return BportfolioItem(
                              url: url,
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        // services
                        Text("Xizmatlar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        BarberServices(services: services),
                        SizedBox(height: 20),

                        // social icons
                        SocialIcons(
                          url: [
                            'tel:+998944574775',
                            'https://t.me/uzmujf2020',
                            'https://www.instagram.com/alixonov_i/'
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
      ),
    );
  }
}
