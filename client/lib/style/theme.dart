import 'package:flutter/material.dart';

BorderRadius borderRadius = BorderRadius.circular(20);

// Hex to rgba: https://rgbacolorpicker.com/hex-to-rgba

// const Color mainColor = Color.fromRGBO(79, 58, 208, 1);
const Color shopAction = Color.fromARGB(255, 21, 10, 218);
const Color shopPrimary = Color.fromRGBO(242, 240, 240, 1);
const Color shopSecondary = Colors.white;
const Color shopGrey = Color.fromRGBO(106, 105, 105, 1);

const TextStyle robotoRegular = TextStyle(
  fontFamily: "ROBOTO",
);
const headerShadowColor = Color.fromRGBO(173, 163, 163, 0.25);

ThemeData shopTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        toolbarHeight: 62,
        shadowColor: headerShadowColor,
        surfaceTintColor: Colors.transparent),
    brightness: Brightness.light,
    scaffoldBackgroundColor: shopPrimary,
    // Define the default font family.
    fontFamily: "ROBOTO",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        color: shopPrimary,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ));
