import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primary = Color(0xff303F9F);
const onPrimary = Color(0xff7986CB);
const secondary = Color(0xff00796B);
const onSecondary = Color(0xff4DB6AC);
const background = Color(0xffE8EAF6);
const onBackground = Color(0xffC5CAE9);
const text = Colors.black;
const success = Color(0xff388E3C);
const error = Color(0xffD32F2F);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor:primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    background: background,
    onBackground: onBackground,
    error: error,
    onSurface: success,
    surface: Colors.black,
  ),
  fontFamily: GoogleFonts.aBeeZee().fontFamily,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: text,
      fontSize: 18,
      letterSpacing: 1,
    ),
      displayMedium: TextStyle(
        color: text,
        letterSpacing: 1,
      ),
    titleLarge: TextStyle(
      color: text,
      letterSpacing: 1,
    ),
    bodyLarge: TextStyle(
      color: text,
      letterSpacing: 1,
    ),
    labelMedium: TextStyle(
      color: text,
      letterSpacing: 1,
      fontSize: 15,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: onSecondary,
  ),
);