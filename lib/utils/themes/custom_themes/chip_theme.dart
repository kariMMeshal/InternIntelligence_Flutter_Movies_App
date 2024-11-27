import 'package:flutter/material.dart';

class KChipTheme {
  KChipTheme._();

  static ChipThemeData lightChipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.black),
    selectedColor: Colors.blue,
    padding: EdgeInsets.all(12),
    checkmarkColor: Colors.white
  );
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: Colors.blue,
    padding: EdgeInsets.all(12),
    checkmarkColor: Colors.white
  );



}
