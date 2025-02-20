import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final Color? color;
  final Gradient? gradient;
  const SocialIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: icon,
      ),
      iconSize: 30,
      onPressed: onPressed,
    );
  }
}
