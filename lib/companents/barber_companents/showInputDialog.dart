import 'package:barber_queue/providers/barberProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void ShowInputDialog(BuildContext context, String field, String content) {
  TextEditingController _controller = TextEditingController();
  String _errorText = '';

  void _validateInput() {
    if (_controller.text.isEmpty) {
      _errorText = 'Iltimos, ma\'lumot kiriting';
    } else {
      _errorText = '';
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          content,
          style: TextStyle(color: Colors.white),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Ma\'lumot kiriting',
                    errorText: _errorText.isEmpty ? null : _errorText,
                  ),
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Bekor QIlish',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _validateInput();
                  });
                  if (_errorText.isEmpty) {
                    Provider.of<BarberProvider>(context, listen: false)
                        .updateBarberData(field, _controller.text);
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          ),
        ],
      );
    },
  );

}
