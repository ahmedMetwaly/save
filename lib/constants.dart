import 'package:flutter/material.dart';

class Constants {
  static final kDarkTheme = ThemeData(
    primaryColor: const Color(0xFFFBE4D8),
    primarySwatch: const MaterialColor(0xFF522B5B, {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    }),
    canvasColor: const Color(0xFF190019),
    indicatorColor: const Color.fromRGBO(136, 14, 79, 1),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(136, 14, 79, .8),
      iconTheme: IconThemeData(
        color: Color(0xFFFBE4D8),
      ),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontFamily: "assets/fonts/Michroma-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFFFBE4D8),
        fontSize: 22,
        fontFamily: "assets/fonts/Michroma-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        color: Color(0xFFFBE4D8),
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 184, 167, 157),
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
      labelMedium: TextStyle(
        fontSize: 18,
        color: Color(0xFFFBE4D8),
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelPadding: EdgeInsets.all(15),
      labelColor: Color(0xFFFBE4D8),
      unselectedLabelStyle: TextStyle(
        fontSize: 20,
      ),
      labelStyle: TextStyle(
        fontSize: 25,
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
      Color.fromRGBO(136, 14, 79, 1),
    ))),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(136, 14, 79, 1),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 18,
        color: const Color(0xFFFBE4D8).withOpacity(0.5),
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
      contentPadding:
          const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFFFBE4D8),
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFFFBE4D8),
          )),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color.fromRGBO(136, 14, 79, 1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFFFBE4D8),
          )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFFFBE4D8),
          )),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      collapsedBackgroundColor: const Color(0xFFFBE4D8),
      collapsedTextColor: const Color.fromRGBO(136, 14, 79, 1),
      collapsedIconColor: const Color.fromRGBO(136, 14, 79, 1),
      backgroundColor: const Color.fromRGBO(136, 14, 79, 1),
      tilePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      textColor: const Color(0xFFFBE4D8),
      iconColor: const Color(0xFFFBE4D8),
      childrenPadding:
          const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
      expandedAlignment: Alignment.centerLeft,
    ),
  );

  static final kLightTheme = ThemeData(
    primaryColor: const Color(0xFF535878),
    primarySwatch: const MaterialColor(0xFF535878, {
      50: Color.fromRGBO(83, 88, 120, .1),
      100: Color.fromRGBO(83, 88, 120, .2),
      200: Color.fromRGBO(83, 88, 120, .3),
      300: Color.fromRGBO(83, 88, 120, .4),
      400: Color.fromRGBO(83, 88, 120, .5),
      500: Color.fromRGBO(83, 88, 120, .6),
      600: Color.fromRGBO(83, 88, 120, .7),
      700: Color.fromRGBO(83, 88, 120, .8),
      800: Color.fromRGBO(83, 88, 120, .9),
      900: Color.fromRGBO(83, 88, 120, 1),
    }),
    canvasColor: const Color.fromRGBO(184, 216, 227, 1),
    indicatorColor: const Color(0xFF535878),
    appBarTheme:  const AppBarTheme(
      backgroundColor: Color.fromRGBO(83, 88, 120, .8),

      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontFamily: "assets/fonts/Michroma-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
      surfaceTintColor: Color.fromRGBO(184, 216, 227, 1),
     // foregroundColor: Color.fromRGBO(83, 88, 120, .8),
    ),
  
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF535878),
        fontSize: 22,
        fontFamily: "assets/fonts/Michroma-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        color:  Colors.white,
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
      labelMedium: TextStyle(
        fontSize: 18,
        color: Color(0xFF535878),
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 184, 167, 157),
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelPadding: EdgeInsets.all(15),
      labelColor: Color(0xFF535878),
      unselectedLabelStyle: TextStyle(
        fontSize: 20,
      ),
      labelStyle: TextStyle(
        fontSize: 25,
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
      Color(0xFF535878),
    ))),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF535878),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 18,
        color: const Color(0xFF535878).withOpacity(0.5),
        fontFamily: "assets/fonts/Spinnaker-Regular.ttf",
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        overflow: TextOverflow.ellipsis,
      ),
      contentPadding:
          const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFF535878),
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFF535878),
          )),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color(0xFFCEA0AA),
        ),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFF535878),
          )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFF535878),
          )),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      collapsedBackgroundColor: const Color(0xFF535878),
      collapsedTextColor:  Colors.white ,
      collapsedIconColor: Colors.white,
      backgroundColor: const Color(0xFF535878).withOpacity(0.3),
      tilePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      textColor: const Color(0xFF535878),
      iconColor: const Color(0xFF535878),
      childrenPadding:
          const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
      expandedAlignment: Alignment.centerLeft,
    ),
  );
}
