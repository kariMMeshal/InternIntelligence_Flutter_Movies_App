import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
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

  static longtextButton({
    required String title,
    required IconData iconData,
    required Color backGroundColor,
    Function? ontap,
  }) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          backGroundColor,
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(180, 50),
        ),
      ),
      onPressed: () {
        ontap!();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(iconData, color: Colors.white),
          Text(
            title,
            style: KCustomTextStyle.buttonTextStyle(),
          ),
        ],
      ),
    );
  }
}
