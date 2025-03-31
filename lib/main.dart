import 'package:barber_queue/providers/authProvider.dart';
import 'package:barber_queue/providers/barberProvider.dart';
import 'package:barber_queue/providers/imgProvider.dart';
import 'package:barber_queue/providers/userProvider.dart';
import 'package:barber_queue/services/checkUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDAvYRcDHTQ_CwDf-IdkW88fEBcFpXhYEo",
            authDomain: "barber-queue-c0c6f.firebaseapp.com",
            projectId: "barber-queue-c0c6f",
            storageBucket: "barber-queue-c0c6f.firebasestorage.app",
            messagingSenderId: "1070760489397",
            appId: "1:1070760489397:web:7991816adeb2f0cdec69fc",
            measurementId: "G-0Y8552Y040"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context)=> BarberProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => Imgprovider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBarber',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.oswaldTextTheme()),
      home: CheckUserScreen(),
    );
  }
}
