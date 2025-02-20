import 'package:barber_queue/pages/user_pages/user_queue.dart';
import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
              size: 32,
              color: Colors.amber,
            )),
        Text(
          "SALOM JANOB",
          style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserQueue()));
          },
          icon: Icon(
            Icons.notifications_active_rounded,
            size: 28,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
