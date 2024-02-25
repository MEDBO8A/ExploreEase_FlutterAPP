import 'package:flutter/material.dart';

class MyFNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? error;

  const MyFNameTextField({
    super.key,
    required this.controller, this.error,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      style: TextStyle(
        letterSpacing: 1,
        color: themeColors.surface,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: themeColors.onBackground,
        errorText: error,
        errorStyle: TextStyle(
          color: themeColors.error,
          fontSize: 15,
        ),
        hintText: " First Name",
        prefixIcon: Icon(Icons.person, color: themeColors.surface),
        hintStyle: TextStyle(
          letterSpacing: 1,
          color: themeColors.surface,
          fontSize: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 3,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 3,
          ),
        ),
      ),
    );
  }
}


class MyLNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? error;

  const MyLNameTextField({
    super.key,
    required this.controller, this.error,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      style: TextStyle(
        letterSpacing: 1,
        color: themeColors.surface,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: themeColors.onBackground,
        errorText: error,
        errorStyle: TextStyle(
          color: themeColors.error,
          fontSize: 15,
        ),
        hintText: " Last Name",
        prefixIcon: Icon(Icons.person, color: themeColors.surface),
        hintStyle: TextStyle(
          letterSpacing: 1,
          color: themeColors.surface,
          fontSize: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 3,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 3,
          ),
        ),
      ),
    );
  }
}



class MyNumTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? error;

  const MyNumTextField({
    super.key,
    required this.controller, this.error,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      style: TextStyle(
        letterSpacing: 1,
        color: themeColors.surface,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: themeColors.onBackground,
        errorText: error,
        errorStyle: TextStyle(
          color: themeColors.error,
          fontSize: 15,
        ),
        hintText: " Phone Number",
        prefixIcon: Icon(Icons.phone, color: themeColors.surface),
        hintStyle: TextStyle(
          letterSpacing: 1,
          color: themeColors.surface,
          fontSize: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 3,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 3,
          ),
        ),
      ),
    );
  }
}

