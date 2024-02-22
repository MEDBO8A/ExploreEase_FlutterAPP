import 'package:flutter/material.dart';
import 'package:project/screens/sign_in_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1,vertical: screenHeight * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email_outlined,
              color: themeColors.surface,
              size: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Verify your email address",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "We have just send email verification link to your emai. Please check it and click on that link to verify your Email adresse.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColors.onSecondary,
                  side: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MySignInScreen(),
                    ),
                  );
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeColors.surface,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
