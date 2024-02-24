import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/welcome_screen.dart';
import 'auth_services.dart';

class MyState extends StatefulWidget {
  const MyState({super.key});

  @override
  State<MyState> createState() => _MyStateState();
}

class _MyStateState extends State<MyState> {
  User? user;
  AuthServices auth = AuthServices();

  Future<void> getUser() async {
    final userRes = auth.getUser();
    setState(() {
      user = userRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return user != null ? const MyHomeScreen() : const MyWelcomeScreen();
  }
}
