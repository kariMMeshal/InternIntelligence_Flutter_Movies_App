import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';

class KCustomButtonStyle {
  KCustomButtonStyle._();

  static ButtonStyle categoryButtonStyle() {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        const Size(100, 10),
      ),
      backgroundColor: WidgetStateProperty.all(KColors.buttonPrimary),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }



  
}
