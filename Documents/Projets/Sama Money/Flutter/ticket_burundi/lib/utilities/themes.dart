import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_burundi/utilities/constants.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: kSecondaryColor),
      gapPadding: 10);
  return InputDecorationTheme(
    // fillColor: kSecondaryColor.withOpacity(0.5),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18));
}

ButtonStyle defaultButtonStyle() => ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: kButtonColor,
      minimumSize: const Size(200, 60),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );

ButtonStyle authButtonStyle() => ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: kButtonColor,
      minimumSize: const Size(350, 65),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );

ButtonStyle defaultButtonHomeStyle() => ElevatedButton.styleFrom(
    onPrimary: Colors.black,
    primary: kButtonColor,
    minimumSize: const Size(400, 60),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    alignment: Alignment.centerLeft);

ButtonStyle outlinedButtonStyle() => OutlinedButton.styleFrom(
      primary: Colors.white,
      side: const BorderSide(color: Colors.white, width: 2),
      minimumSize: const Size(200, 60),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    );

ButtonStyle payementButtonStyle() => ElevatedButton.styleFrom(
      onPrimary: kPrimaryColor,
      primary: Colors.white,
      minimumSize: const Size(200, 60),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    );
