import 'package:flutter/material.dart';

const String appelStart = 'jesuisla';
const kTextFieldContainerBoxDecoration = BoxDecoration(
  color: Color(0xFFEDEEEE),
  borderRadius: _cornerRadius,
);

const _rowHeight = 10.0;
const _cornerRadius = BorderRadius.all(Radius.circular(_rowHeight));

const kTextFieldStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18.0, color: Color(0xFF01224b));

const kTextFieldContainerPadding =
    EdgeInsets.only(left: 1.0, right: 1.0, top: 1.0, bottom: 1.0);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Entrez le numéro du bénéficiaire',
  contentPadding: EdgeInsets.only(left: 5),
  hintStyle: TextStyle(
      letterSpacing: 0.0,
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87),
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  /* enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xFFa7a3a3),
          width: 1.0)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xFFD61A0E),
          width: 1.0)),*/
);

const kTextFieldStylePassword = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18.0, color: Color(0xFF01224b));

const kTextFieldContainerPaddingPassword =
    EdgeInsets.only(left: 2.0, right: 2.0, top: 4.0, bottom: 4.0);

const kTextFieldDecorationPassword = InputDecoration(
  contentPadding: EdgeInsets.only(left: 5),
  hintText: 'Entrez le numéro du bénéficiaire',
  hintStyle: TextStyle(
      letterSpacing: 0.0,
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87),
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
);
