import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';

class KCustomTextStyle {
  KCustomTextStyle._();

  static TextStyle buttonTextStyle() {
    return const TextStyle(
        color: KColors.textWhite,
        fontSize: 18.0, // Text size
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8);
  }

  static TextStyle sectionsTextStyle() {
    return const TextStyle(
        color: KColors.textWhite,
        fontSize: 26.0, // Text size
        fontWeight: FontWeight.bold,
        letterSpacing: 1);
  }

  static TextStyle titleTextStyle() {
    return const TextStyle(
      color: KColors.textWhite,
      fontSize: 35.0, // Text size
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    );
  }

  static TextStyle subTitleTextStyle() {
    return const TextStyle(
      color: KColors.grey,
      fontSize: 13.0, // Text size
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    );
  }
}
