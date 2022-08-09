import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF01224b);
const kButtonColor = Color(0xFF2369c0);
const kAppBarColor = Color.fromRGBO(187, 222, 251, 1);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kErrorColor = Color.fromARGB(255, 165, 15, 4);

const kPlatinumColor = Color(0xFFE5E4E2);
const kGoldColor = Color(0xFFFFD700);
const kSilverColor = Color(0xFFC0C0C0);
const kBronzeColor = Color(0xFFCD7F32);
const kVvipColor = Color.fromARGB(255, 101, 99, 97);

const kPrimaryGradientColor = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0, 0.7],
    colors: [kPrimaryColor, kPrimaryColor]);

const kSecondaryGradientColor = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.4, 1],
    colors: [kPrimaryColor, Color.fromARGB(255, 215, 211, 235)]);

const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: kTextColor));
}

// =============================================================================================

const kTextFieldContainerBoxDecoration = BoxDecoration(
  color: Color(0xFFEDEEEE),
  borderRadius: _cornerRadius,
);

const _rowHeight = 10.0;
const _cornerRadius = BorderRadius.all(Radius.circular(_rowHeight));

const kTextFieldStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xFF01224b));

const kHomeButtonTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 22.0,
  color: Colors.white,
);

const kTextFieldContainerPadding =
    EdgeInsets.only(left: 10.0, right: 1.0, top: 1.0, bottom: 1.0);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(18),
  fillColor: Colors.white,
  hintStyle: TextStyle(
      letterSpacing: 0.0,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87),
);

const kLanguageFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
      letterSpacing: 0.0,
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.white),
);
