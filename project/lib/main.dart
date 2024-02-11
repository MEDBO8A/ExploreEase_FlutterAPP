import 'package:flutter/material.dart';
import 'package:project/screens/welcome/welcome_screen.dart';
import 'package:project/themes/dark_theme.dart';
import 'package:project/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: MyWelcomeScreen(),
    );
  }
}
