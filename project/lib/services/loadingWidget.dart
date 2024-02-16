// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

Future loading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Container(
        height: 30,
        width: 30,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  );
}
