import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';

class KNavbarTheme {
  KNavbarTheme._();

  static const lightNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: KColors.secondary, 
    selectedItemColor: KColors.white, 
    unselectedItemColor: Colors.grey, 
    elevation: 5, // 
  );
  static const darkNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: KColors.secondary, 
    selectedItemColor: KColors.white, 
    unselectedItemColor: Colors.grey, 
    elevation: 5, // 
  );



}
