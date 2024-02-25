import 'package:flutter/material.dart';
import 'package:project/screens/home_screen.dart';
class NoConnectionRow extends StatelessWidget {
  const NoConnectionRow({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme
        .of(context)
        .colorScheme;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: themeColors.error,
              ),
              Text(
                "Check Your Internet!   ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: themeColors.error,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColors.secondary,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyHomeScreen())); // Cancel button
                },
                child: const Text(
                  "Retry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}


NoConnectionAlert(BuildContext context){
  final themeColors = Theme
      .of(context)
      .colorScheme;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Row(
          children: [
            Icon(
              Icons.error,
              color: themeColors.error,
            ),
            const SizedBox(width: 10),
            Text(
              'Error',
              style: TextStyle(
                color: themeColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          "Check Your Internet!  ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: themeColors.surface,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColors.secondary,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyHomeScreen())); // Cancel button
            },
            child: const Text(
              "Retry",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
        backgroundColor: themeColors.background,
      );
    },
  );
}
