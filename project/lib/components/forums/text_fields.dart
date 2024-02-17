import 'package:flutter/material.dart';

class MyMailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? error;

  const MyMailTextField({
    Key? key,
    required this.controller, this.error,
  }) : super(key: key);

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
        errorStyle: TextStyle(
          color: themeColors.error,
          fontSize: 15,
        ),
        errorText: error,
        hintText: " Email",
        prefixIcon: Icon(Icons.email_rounded, color: themeColors.surface),
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


class MyNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? error;

  const MyNameTextField({
    Key? key,
    required this.controller, this.error,
  }) : super(key: key);

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
        hintText: " Username",
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



class MyPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? error;

  const MyPasswordTextField({
    Key? key,
    required this.controller,
    this.error,
  }) : super(key: key);

  @override
  _MyPasswordTextFieldState createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.controller,
      obscureText: !isVisible,
      style: TextStyle(
        letterSpacing: 1,
        color: themeColors.surface,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: themeColors.onBackground,
        errorText: widget.error,
        errorStyle: TextStyle(
          color: themeColors.error,
          fontSize: 15,
        ),
        hintText: " Password",
        prefixIcon: Icon(Icons.lock, color: themeColors.surface),
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
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          color: themeColors.surface,
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
      ),
    );
  }
}

class MySearchTextField extends StatelessWidget {
  final String? error;

  const MySearchTextField({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return TextFormField(
      style: TextStyle(
        letterSpacing: 1,
        color: themeColors.surface,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: themeColors.onBackground,
        errorStyle: TextStyle(
          color: themeColors.error,
          fontSize: 15,
        ),
        errorText: error,
        hintText: "Search for a package here",
        prefixIcon: Icon(Icons.search, color: themeColors.surface),
        hintStyle: TextStyle(
          letterSpacing: 1,
          color: themeColors.surface,
          fontSize: 18,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
      ),
    );
  }
}
