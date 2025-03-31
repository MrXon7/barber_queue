import 'package:flutter/material.dart';

// ignore: must_be_immutable
class myTextFormField extends StatelessWidget {
  final String label;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  Widget? prefix;
  myTextFormField(
      {super.key,
      required this.label,
      required this.validator,
      required this.onSaved,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          label: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          prefix: prefix),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
