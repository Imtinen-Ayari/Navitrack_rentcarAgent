import 'package:flutter/material.dart';
import 'package:rent_car/Pages/HomePage.dart';
import 'package:rent_car/Pages/SplachScreen.dart';
import 'package:rent_car/Pages/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart'; // firebase
import 'package:rent_car/Pages/SignIn.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(); // 👈 Firebase must be initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0060FC), // Your Bleu
          secondary: Color(0xFF000000), // Noir
          surface: Colors.white, // Blanc
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
        ),
        dialogBackgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
      routes: {
        '/Home': (context) => HomePage(),
        '/Welcome': (context) => WelcomePage(),
        '/login': (context) => SignInPage(),
      },
    );
  }
}
