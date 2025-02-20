import 'package:barber_queue/companents/socialIcon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcons extends StatelessWidget {
  final List<String> url;
  const SocialIcons({
    super.key, required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIcon(
          icon: Icon(
            Icons.call,
            color: Colors.white,
          ),
          color: Colors.green,
          onPressed: () => launch(url[0]),
        ),
        SocialIcon(
          icon: Icon(
            Icons.telegram,
            color: Colors.blue,
          ),
          onPressed: () => launch(url[1]),
          color: Colors.white,
        ),
        SocialIcon(
          icon: Icon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFFF58529), // Orange
              Color(0xFFDD2A7B), // Red/Pink
              Color(0xFF8134AF), // Purple
              Color(0xFF515BD4), // Blue
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          onPressed: () => launch(url[2]),
        ),
      ],
    );
  }
}
