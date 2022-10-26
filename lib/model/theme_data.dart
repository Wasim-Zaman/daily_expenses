import "package:flutter/material.dart";

ThemeData themeData(
  MaterialColor primaryColor,
  MaterialColor accentColor,
) {
  return ThemeData(
    primarySwatch: primaryColor,
    accentColor: accentColor,
    fontFamily: 'Quicksand',
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          fontFamily: 'OpenSans', fontSize: 25, fontWeight: FontWeight.bold),
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        // color: Theme.of(context).primaryColorLight,
      ),
      headline5: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      button: TextStyle(
        color: Colors.white,
        // fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    ),
  );
}
