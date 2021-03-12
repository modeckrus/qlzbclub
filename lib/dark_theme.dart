import 'package:flutter/material.dart';

import 'color_extention.dart';


class MyDartTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: HexColor.fromHex('#1D252C'),
    hoverColor: HexColor.fromHex('#008B94'),
    appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        //  color: HexColor.fromHex('#008B94')),
        color: HexColor.fromHex('#181e24')),
    bottomAppBarColor: HexColor.fromHex('#181e24'),
    bottomAppBarTheme: BottomAppBarTheme(color: HexColor.fromHex('#181e24')),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor.fromHex('#181e24')),
    canvasColor: HexColor.fromHex('#181e24'),
    dialogBackgroundColor: HexColor.fromHex('#181e24'),
  );
}
