import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemes {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: const Color(0xff000000),
    focusColor: const Color(0xff444444),
    disabledColor: const Color(0xff222222),
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: Colors.white,
      ),
      backgroundColor: const Color(0xff222222),
    ),
    primaryTextTheme: const TextTheme(
      headline1:
          TextStyle(color: Colors.white, fontSize: 54, fontFamily: "MooLahLah"),
      bodyText1:
          TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Itim"),
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: const Color(0xfff9fbfc),
    focusColor: const Color(0xffffffff),
    disabledColor: const Color(0xffdddddd),
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: Colors.white,
      ),
      backgroundColor: const Color(0xff222222),
    ),
    primaryTextTheme: const TextTheme(
      headline1:
          TextStyle(color: Colors.black, fontSize: 54, fontFamily: "MooLahLah"),
      bodyText1:
          TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Itim"),
    ),
  );
}
