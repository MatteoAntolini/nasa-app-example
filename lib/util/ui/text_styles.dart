import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasa/util/ui/ui_constants.dart';

import 'nasa_colors.dart';

//Text
const Color text86 = Color(0xDB000000);
const Color text80 = Color(0xCC000000);
const Color text70 = Color(0xB3000000);
const Color text60 = Color(0x99000000);
const Color text50 = Color(0x80000000);
const Color text38 = Color(0x61000000);

const Color WHITEF1 = Color(0xFFF1F1F1);

class Styles {
  static TextStyle TITLE_STYLE = GoogleFonts.openSans(
      color: DARK_MODE ? WHITEF1 : text86,
      fontSize: 36,
      fontWeight: FontWeight.w800);

  static TextStyle HEADING_STYLE = GoogleFonts.openSans(
      color: DARK_MODE ? WHITEF1 : text80,
      fontSize: 36,
      fontWeight: FontWeight.w600);

  static TextStyle HINT_STYLE = GoogleFonts.openSans(
    color: text50,
    fontSize: 16,
  );

  static TextStyle F1BODY_STYLE =
      GoogleFonts.openSans(fontSize: 16, color: WHITEF1);

  static TextStyle FLAT_BUTTON_STYLE = GoogleFonts.openSans(
      decoration: TextDecoration.underline, fontSize: 16, color: WHITEF1);

  static TextStyle F1HEADING_STYLE = GoogleFonts.openSans(
      color: WHITEF1, fontSize: 22, fontWeight: FontWeight.bold);

  static TextStyle ERROR = GoogleFonts.openSans(
    color: Colors.red,
    fontSize: 16,
  );

  static TextStyle H2_STYLE = GoogleFonts.openSans(
      color: DARK_MODE ? WHITEF1 : text70,
      fontSize: 22,
      fontWeight: FontWeight.bold);

  static TextStyle SECONDARY_H2_STYLE = GoogleFonts.openSans(
      color: SECONDARY, fontSize: 22, fontWeight: FontWeight.bold);

  static TextStyle BODY_STYLE = GoogleFonts.openSans(
    color: DARK_MODE ? WHITEF1 : text60,
    fontSize: 16,
  );

  static TextStyle PRIMARY_HEADING = GoogleFonts.openSans(
      color: DARK_MODE ? PRIMARY_LIGHT : PRIMARY,
      fontSize: 22,
      fontWeight: FontWeight.bold);

  static TextStyle APOD_TITLE_STYLE =
      GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle APOD_DATE_STYLE = GoogleFonts.openSans(
    color: SECONDARY,
    fontSize: 12,
  );

  static TextStyle DATE = GoogleFonts.openSans(
    color: SECONDARY,
    fontSize: 18,
  );

  static TextStyle TEXTFIELD_STYLE =
      GoogleFonts.openSans(color: text70, fontSize: 18);
}
