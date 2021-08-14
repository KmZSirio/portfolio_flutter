import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static final black = Color(0xFF000000);

  static final white = Color(0xFFffffff);
  static final whiteMid = Color(0xFFf2f2f2);
  static final darkerWhite = Color(0xFFdadada);

  static final dark    = Color(0xFF262626);
  static final darkMid = Color(0xFF3b3b3b);
  static final lighterDark = Color(0xFF96939b);

  static final yellow = Color(0xFFf2cb29);
  static final darkerYellow = Color(0xFFd9b624);

  static final green = Color(0xFF3ead34);
  static final red   = Color(0xFFad343e);

  static final trans = Colors.transparent;

  static final faGreen = Color(0xFF088a08);
  static final sirioR  = Color(0xff801434);
  static final sirioY  = Color(0xffF3AC20);
  static final sirioG  = Color(0xff94923D);

  static final spotifyGreen = Color(0xff1ED760);
  static final spotifyBlack = Color(0xff121212);
  static final spotifyGreyDarker  = Color(0xff2A2A2A);
  static final spotifyGreyLighter = Color(0xffAFAFAF);
  static final spotifyBlueGrey = Color(0xff506173);
}

class AppTheme {

  //* displayColor:  hl1, 2, 3, 4 and caption.
  //* bodyColor:     remaining

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    buttonColor: AppColors.dark,
    dividerColor: AppColors.lighterDark,
    primaryColor: AppColors.sirioG,
    accentColor: AppColors.sirioR,
    cardColor: AppColors.lighterDark,
    errorColor: AppColors.red,
    canvasColor: AppColors.whiteMid,

    colorScheme: ColorScheme(
      brightness: Brightness.light, 
      background: AppColors.white, 
      error: AppColors.red, 
      onBackground: AppColors.dark, 
      onError: AppColors.white, 
      onPrimary: AppColors.white, 
      onSecondary: AppColors.white, 
      onSurface: AppColors.darkMid, 
      primary: AppColors.darkMid, 
      primaryVariant: AppColors.dark, 
      secondary: AppColors.whiteMid,
      secondaryVariant: AppColors.white,
      surface: AppColors.lighterDark,
    ),

    textTheme: GoogleFonts.ralewayTextTheme().apply(
      displayColor: AppColors.dark,
      bodyColor: AppColors.dark,
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.dark),
        alignment: Alignment.center,
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 10)),
        foregroundColor:  MaterialStateProperty.all<Color>(AppColors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
          fontFamily: GoogleFonts.raleway().fontFamily, fontSize: 17))
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.lighterDark),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.dark, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.dark, width: 2),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.red[700],
      foregroundColor: Colors.white
    ),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all( AppColors.darkerWhite ),
      trackColor: MaterialStateProperty.all( AppColors.white ),
    ),
  );

  //* displayColor:  hl1, 2, 3, 4 and caption.
  //* bodyColor:     remaining

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.dark,
    buttonColor: AppColors.white,
    dividerColor: AppColors.darkerWhite,
    primaryColor: AppColors.sirioG,
    accentColor: AppColors.sirioR,
    cardColor: AppColors.darkerWhite,
    errorColor: AppColors.red,
    canvasColor: AppColors.darkMid,

    colorScheme: ColorScheme(
      brightness: Brightness.dark, 
      background: AppColors.white, 
      error: AppColors.red, 
      onBackground: AppColors.dark, 
      onError: AppColors.white, 
      onPrimary: AppColors.white, 
      onSecondary: AppColors.white, 
      onSurface: AppColors.darkMid, 
      primary: AppColors.darkMid, 
      primaryVariant: AppColors.dark, 
      secondary: AppColors.whiteMid,
      secondaryVariant: AppColors.white,
      surface: AppColors.whiteMid,
    ),

    textTheme: GoogleFonts.ralewayTextTheme().apply(
      displayColor: AppColors.white,
      bodyColor: AppColors.white,
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
          MaterialStateProperty.all<Color>(AppColors.white),
        alignment: Alignment.center,
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 10)),
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.dark),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
          fontFamily: GoogleFonts.raleway().fontFamily, fontSize: 17))
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.lighterDark),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.white, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.white, width: 2),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.red[700],
      foregroundColor: Colors.white
    ),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all( AppColors.sirioR ),
      trackColor: MaterialStateProperty.all( AppColors.sirioR.withOpacity(0.7) ),
    ),
  );

}