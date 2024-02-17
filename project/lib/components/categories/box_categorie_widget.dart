import 'package:flutter/material.dart';

class CategorieBox extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;
  const CategorieBox(
      {super.key,
        required this.name,
        required this.image,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeColors.onBackground,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            Text(
              " ${name}",
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}