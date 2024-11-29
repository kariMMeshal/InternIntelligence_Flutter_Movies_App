import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';

class KCustomTextStyle {
  KCustomTextStyle._();

  static TextStyle buttonTextStyle({Color? color}) {
    return TextStyle(
        color:color ??KColors.textWhite,
        fontSize: 18.0, // Text size
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8);
  }

  static TextStyle sectionsTextStyle() {
    return const TextStyle(
        color: KColors.textWhite,
        fontSize: 24.0, // Text size
        fontWeight: FontWeight.bold,
        letterSpacing: 1);
  }

  static TextStyle titleTextStyle() {
    return const TextStyle(
      color: KColors.textWhite,
      fontSize: 30.0, // Text size
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    );
  }

  static TextStyle subTitleTextStyle() {
    return const TextStyle(
      overflow: TextOverflow.visible,
      color: KColors.textSecondary,
      fontSize: 12.0, // Text size
      fontWeight: FontWeight.bold,
    );
  }
}
