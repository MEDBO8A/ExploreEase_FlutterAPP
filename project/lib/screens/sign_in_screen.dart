import 'package:flutter/material.dart';

class MySignInPage extends StatefulWidget {
  @override
  _MySignInPageState createState() => _MySignInPageState();
}



class _MySignInPageState extends State<MySignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
    );
  }
}