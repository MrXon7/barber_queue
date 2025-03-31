import 'package:barber_queue/pages/user_pages/barber_foruser_page.dart';
import 'package:flutter/material.dart';

class BarberItem extends StatelessWidget {
  BarberItem({
    super.key,
    required this.barber,
    required this.barberId,
  });

  final String barberId;
  final Map<String, dynamic> barber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BarberForuserPage(
                      barberId: barberId,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade800),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade700),
                  image: DecorationImage(
                      image: NetworkImage(
                        barber['profileImage'] ?? 'https://ibb.co/DDdnYwbg',
                      ),
                      fit: BoxFit.fill)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Sartarosh ismi
                Expanded(
                  child: Text(
                    "${barber['fullName']}".toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Lokatsiya
                Icon(
                  Icons.location_on,
                  color: Colors.amber,
                  size: 14,
                ),
                Expanded(
                  child: Text(
                    "Sartarosh Mazili...",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      SizedBox(width: 2),
                      Text(
                        "${barber['rating']}",
                        style: TextStyle(color: Colors.grey.shade500),
                      )
                    ],
                  ),
                  // arrow button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.arrow_right_alt),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
