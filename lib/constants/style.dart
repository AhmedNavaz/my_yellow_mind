import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Contains styles, for example colors, font family and other stuff like that

// Colors
const Color primaryColor = Colors.black;
const Color backGroundColor = Colors.white;

// TEXT THEME
TextStyle customTextStyle(int fontSize, FontWeight fontWeight,
    {Color color = primaryColor}) {
  return GoogleFonts.openSans(
    color: color,
    fontSize: fontSize.toDouble() + 4,
    fontWeight: fontWeight,
  );
}
