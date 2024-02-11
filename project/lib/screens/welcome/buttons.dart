import 'package:flutter/material.dart';

class WelcomeButtons extends StatelessWidget{
  final String content;
  final Color color;
  final bool isDark;
  final VoidCallback onPressed;

  const WelcomeButtons({
    super.key,
    required this.content,
    required this.color,
    required this.isDark,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: heigth*0.022),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Center(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
    );
  }
}