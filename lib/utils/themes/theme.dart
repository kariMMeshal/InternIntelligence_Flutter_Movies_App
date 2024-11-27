import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/themes/custom_themes/appbar_theme.dart';
import 'package:flutter_movie_app_2/utils/themes/custom_themes/bottomsheet_theme.dart';
import 'package:flutter_movie_app_2/utils/themes/custom_themes/checkbox_theme.dart';
import 'package:flutter_movie_app_2/utils/themes/custom_themes/chip_theme.dart';
import 'package:flutter_movie_app_2/utils/themes/custom_themes/elevated_button_theme.dart';
import 'package:flutter_movie_app_2/utils/themes/custom_themes/outlined_button_theme.dart';
import 'package:flutter_movie_app_2/utils/themes/custom_themes/text_field_theme.dart';
import 'package:flutter_movie_app_2/utils/themes/custom_themes/text_theme.dart';

class KAppTheme {
  KAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: KColors.primary,
    scaffoldBackgroundColor: KColors.white,
    textTheme: KTextTheme.lightTextTheme,
    appBarTheme: KAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: KBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: KCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: KChipTheme.lightChipTheme,
    elevatedButtonTheme: KElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: KOutLinedButtonTheme.lightOutLinedButtonTheme,
    inputDecorationTheme: KTextFormFieldTheme.lightInputDecorationTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: KColors.secondary, // Explicitly set the background color
      selectedItemColor: KColors.white, // Set selected icon and text color
      unselectedItemColor: Colors.grey, // Set unselected icon and text color
      elevation: 5, // Add elevation for visibility
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: KColors.primary,
    scaffoldBackgroundColor: KColors.black,
    textTheme: KTextTheme.darkTextTheme,
    appBarTheme: KAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: KBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: KCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: KChipTheme.lightChipTheme,
    elevatedButtonTheme: KElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: KOutLinedButtonTheme.darkOutLinedButtonTheme,
    inputDecorationTheme: KTextFormFieldTheme.darkInputDecorationTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: KColors.secondary, // Explicitly set the background color
      selectedItemColor: KColors.white, // Set selected icon and text color
      unselectedItemColor: Colors.grey, // Set unselected icon and text color
      elevation: 5, // Add elevation for visibility
    ),
  );
}
