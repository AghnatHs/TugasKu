import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GFont {
  static TextStyle get monsterratTitle => GoogleFonts.montserrat(
        letterSpacing: 5,
        fontSize: 20,
      );

  static TextStyle get monsterratTitle2 => GoogleFonts.montserrat(
        letterSpacing: 2,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );

  static TextStyle get dialogTitle => GoogleFonts.yantramanav(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}

TextDecoration strikethroughDecoration(bool isDone) {
  return isDone ? TextDecoration.lineThrough : TextDecoration.none;
}
