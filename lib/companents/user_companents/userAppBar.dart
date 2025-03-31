import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final String username;
  UserAppBar({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
            "SALOM $username".toUpperCase(),
            style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
          SizedBox(
            width: 28,
          )
        ],
      ),
    );
  }
}
