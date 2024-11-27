import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';

class KCustomIconbutton {
  KCustomIconbutton._();

  static Container kiconButton({
    required Icon icon,
    required Function ontap,
  }) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: KColors.darkGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () => ontap(),
        icon: icon,
        iconSize: 30,
        color: Colors.white,
      ),
    );
  }
}
