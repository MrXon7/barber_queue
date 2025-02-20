import 'package:barber_queue/pages/barber_pages/barberHomePage.dart';
import 'package:barber_queue/pages/navig.dart';
import 'package:barber_queue/pages/user_pages/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.oswaldTextTheme()),
      home: Navig(),
    );
  }
}
