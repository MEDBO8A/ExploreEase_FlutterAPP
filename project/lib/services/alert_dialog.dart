import 'package:flutter/material.dart';

showErrorAlert(BuildContext context, String? message) {
  final themeColors = Theme.of(context).colorScheme;
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
            SizedBox(width: 10),
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
          message!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
    },
  );
}


Future showSuccessAlert(BuildContext context,String message) {
  final themeColors = Theme.of(context).colorScheme;
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
                Icons.check_circle,
                color: themeColors.onSurface,
              ),
              SizedBox(width: 10),
              Text(
                'Success',
                style: TextStyle(
                  color: themeColors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
