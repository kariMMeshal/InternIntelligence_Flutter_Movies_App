import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';

class KLongTextButton {
  
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

