import 'package:english_dictionary/screens/index.dart';
import 'package:english_dictionary/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepOrange,secondaryHeaderColor: Colors.deepOrangeAccent),
      home: SplashScreen()
    );
  }
}
