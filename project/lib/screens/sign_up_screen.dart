import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/screens/sign_in_screen.dart';

import '../components/sign in&up components/buttons.dart';
import '../forums/text_fields.dart';
import '../services/authServices.dart';

class MySignUpScreen extends StatefulWidget {
  @override
  _MySignUpScreenState createState() => _MySignUpScreenState();
}



class _MySignUpScreenState extends State<MySignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  AuthServices auth = AuthServices();

  String? _emailError;
  String? _passError;
  String? _nameError;

  void _validateInputs() {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    setState(() {
      _emailError = null;
      _passError = null;
      _nameError = null;

      if (_nameController.text.isEmpty){
        _nameError = "Username cannot be empty";
      }

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
                      fontSize: 55,
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
                    Text("Enter your Username",style: theme.textTheme.titleMedium),

                    addVerticalSpace(screenHeight * 0.01),

                    MyNameTextField(
                      controller: _nameController,
                      error: _nameError,
                    ),

                    addVerticalSpace(screenHeight * 0.03),

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

                    addVerticalSpace(screenHeight * 0.04),

                    MainButtonWidget(
                      content: "Sign Up",
                      onPressed: () async{
                        _validateInputs();
                        if (_emailError == null && _passError == null && _nameError == null){
                          auth.signUp(context, _nameController.text, _emailController.text, _passController.text);
                        }
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have an Account ?",style: theme.textTheme.titleMedium),
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MySignInScreen()),);
                          },
                          child: Text(
                            " Sign in",
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