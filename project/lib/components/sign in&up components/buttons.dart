import 'package:flutter/material.dart';
import 'package:project/services/authServices.dart';

class GoogleButtonWidget extends StatelessWidget{
  final auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        auth.logInWithGoogle(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: themeColors.onSecondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/google.png",
              width: 30,
              height: 30,
            ),
            SizedBox(width: 15,),
            Text(
              "Sign in with google",
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainButtonWidget extends StatelessWidget{
  final String content;
  final VoidCallback onPressed;

  const MainButtonWidget({
    super.key,
    required this.content,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: themeColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
              content,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
        ),
      ),
    );
  }
}

