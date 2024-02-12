import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/screens/sign_up_screen.dart';

import '../components/sign in&up components/buttons.dart';
import '../forums/text_fields.dart';

class MySignInScreen extends StatefulWidget {
  @override
  _MySignInScreenState createState() => _MySignInScreenState();
}



class _MySignInScreenState extends State<MySignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String? _emailError;
  String? _passError;

  void _validateInputs() {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    setState(() {
      _emailError = null;
      _passError = null;

      if (_emailController.text.isEmpty) {
        _emailError = 'Email cannot be empty';
      }else if (!emailRegExp.hasMatch(_emailController.text)){
        _emailError = 'This is not a valid Email';
      }

      if (_passController.text.isEmpty) {
        _passError = 'Password cannot be empty';
      } else if (_passController.text.length < 6) {
        _passError = 'Password must be at least 6 characters';
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  themeColors.surface == Colors.white? Image.asset(
                      "assets/images/dark_logo.png",
                      width: screenWidth * 0.4,
                  )
                      : Image.asset(
                      "assets/images/light_logo.png",
                    width: screenWidth * 0.4,
                    ),
                  Text(
                    "Explore \n  Ease",
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontFamily: GoogleFonts.bahiana().fontFamily,
                      fontSize: screenWidth * 0.15,
                      color: themeColors.primary,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
        
              addVerticalSpace(screenHeight * 0.03),
        
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter your Email",style: theme.textTheme.titleMedium),
                    addVerticalSpace(screenHeight * 0.01),
                    MyMailTextField(
                        controller: _emailController,
                      error: _emailError,
                    ),
                    addVerticalSpace(screenHeight * 0.03),
                    Text("Enter your Password",style: theme.textTheme.titleMedium),
                    addVerticalSpace(screenHeight * 0.01),
                    MyPasswordTextField(
                      controller: _passController,
                      error: _passError,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                          "Forgot Password ? ",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: themeColors.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(screenHeight * 0.03),
                    MainButtonWidget(
                        content: "Sign In",
                        onPressed: (){
                          _validateInputs();
                        },
                    ),
                    addVerticalSpace(screenHeight * 0.02),
                    GoogleButtonWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Account ?",style: theme.textTheme.titleMedium),
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MySignUpScreen()),);
                          },
                          child: Text(
                            " Sign up",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: themeColors.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}