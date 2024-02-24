import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/forums/text_fields.dart';
import '../helping widgets/sizedbox_widget.dart';
import '../helping widgets/alert_dialog.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _emailController = TextEditingController();
  String? _emailError;

  void _validateInputs() {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    setState(() {
      _emailError = null;

      if (_emailController.text.isEmpty) {
        _emailError = 'Email cannot be empty';
      }else if (!emailRegExp.hasMatch(_emailController.text)){
        _emailError = 'This is not a valid Email';
      }
    }
    );
  }

  void resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Navigator.pop(context);
      showSuccessAlert(context, "Password reset link sent! check your email");
    } on FirebaseAuthException catch (e) {
      showErrorAlert(context, e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenHeight * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter your Email",style: theme.textTheme.titleMedium),
            addVerticalSpace(screenHeight * 0.01),
            MyMailTextField(
              controller: _emailController,
              error: _emailError,
            ),
            addVerticalSpace(screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColors.primary,
                  ),
                  onPressed: () {
                    _validateInputs();
                    if (_emailError == null){
                      resetPassword();
                    }
                  },
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColors.onSecondary,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
