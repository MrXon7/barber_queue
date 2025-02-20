import 'package:barber_queue/pages/user_pages/user_queue.dart';
import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserQueue(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: Center(
              child: Text(
                'Navbatga qo\'shilish',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
    );
  }
}
