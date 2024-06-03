import 'package:flutter/material.dart';

BorderRadius borderRadius = BorderRadius.circular(20);

// Hex to rgba: https://rgbacolorpicker.com/hex-to-rgba

// const Color mainColor = Color.fromRGBO(79, 58, 208, 1);
const Color shopBlack = Colors.black;
const Color shopGrey1 = Color.fromRGBO(106, 105, 105, 1);
const Color shopGrey2 = Color.fromRGBO(217, 217, 217, 1);

const TextStyle robotoRegular = TextStyle(
  fontFamily: "ROBOTO",
);
const headerShadowColor = Color.fromRGBO(173, 163, 163, 0.25);

ThemeData shopTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      shadowColor: headerShadowColor,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    // Define the default font family.
    fontFamily: "ROBOTO",
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        color: shopBlack,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        fontSize: 25,
        color: shopBlack,
        fontWeight: FontWeight.w400,
      ),
      headline3: TextStyle(
        fontSize: 20,
        color: shopBlack,
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        fontSize: 17,
        color: shopBlack,
        fontWeight: FontWeight.w400,
      ),
      subtitle1: TextStyle(
        fontSize: 20,
        color: shopGrey1,
        fontWeight: FontWeight.w400,
      ),
      subtitle2: TextStyle(
        fontSize: 17,
        color: shopGrey1,
        fontWeight: FontWeight.w400,
      ),
      caption: TextStyle(
        fontSize: 13,
        color: shopBlack,
        fontWeight: FontWeight.w400,
      ),
    ));
