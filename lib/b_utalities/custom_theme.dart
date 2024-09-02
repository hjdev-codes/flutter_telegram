import 'package:flutter/material.dart';

// Custom Light Theme
final ThemeData lightTheme = ThemeData(
  secondaryHeaderColor: const Color(0xFF5A8FBB),
  dividerColor: const Color(0xFF656565), // color #656565,
  cardColor: Colors.white30,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  indicatorColor: const Color.fromARGB(117, 33, 33, 33),
  drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      scrimColor: Color(0xFF5A8FBB),
      surfaceTintColor: Color(0xFF5085B1)),
);

// Custom Dark Theme
final ThemeData darkTheme = ThemeData(
    secondaryHeaderColor: Colors.black,
    indicatorColor: Colors.transparent,
    cardColor: Colors.black,
    brightness: Brightness.dark,
    primaryColor: Colors.black38,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF233040),
      scrimColor: Color(0xFF1C242F),
      surfaceTintColor: Color(0xFF559CDE),
    ),
    dividerColor: Colors.white);



// Color(0xFF233040),
// Color(0xFF1C242F),
// Color(0xFF559CDE),
// Color(0xFF5A8FBB),
// Color(0xFF5085B1),