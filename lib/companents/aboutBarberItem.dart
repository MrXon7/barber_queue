import 'package:barber_queue/pages/user_pages/barber_foruser_page.dart';
import 'package:flutter/material.dart';

class BarberItem extends StatelessWidget {
  const BarberItem({
    super.key,
    required this.barberList,
    required this.holatlist,
    required this.index,
  });

  final List barberList;
  final List holatlist;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BarberForuserPage(
                      img: barberList[index],
                      holat: holatlist[index],
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
                      image: AssetImage(
                        'assets/images/${barberList[index]}.jpg',
                      ),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${barberList[index]}".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.amber,
                  size: 14,
                ),
                Expanded(
                  child: Text(
                    'Saroy MFY, Namangan ko\'cha nechinchidir uy',
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
                        "${index + 2.5}",
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
