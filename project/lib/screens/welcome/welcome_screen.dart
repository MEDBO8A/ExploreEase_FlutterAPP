import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/screens/sign_in_screen.dart';
import 'package:project/screens/sign_up_screen.dart';
import 'package:project/screens/welcome/buttons.dart';

class MyWelcomeScreen extends StatefulWidget {
  @override
  _MyWelcomeScreenState createState() => _MyWelcomeScreenState();
}

class _MyWelcomeScreenState extends State<MyWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final themeColors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: themeColors.background,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                themeColors.surface == Colors.black? Transform.scale(
                  scale: width * 0.0025, // Adjust the scale factor to make it smaller
                  child: Image.asset(
                    "assets/images/dark_logo.png",
                  ),
                )
                    : Transform.scale(
                  scale: width * 0.0025, // Adjust the scale factor to make it smaller
                  child: Image.asset(
                    "assets/images/light_logo.png",
                  ),
                ),
                Text(
                  "Welcome.\n Start your Journey of exploring the world with us.\n We offer a different cool packages for many wonderfull places.",
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(height * 0.1),
                WelcomeButtons(
                  content: "Sign In",
                  color: themeColors.primary,
                  isDark: themeColors.surface == Colors.black,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MySignInPage(),),);
                  },
                ),
                addVerticalSpace(height * 0.02),
                WelcomeButtons(
                  content: "Sign Up",
                  color: themeColors.onPrimary,
                  isDark: themeColors.surface == Colors.black,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MySignUpPage(),),);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}