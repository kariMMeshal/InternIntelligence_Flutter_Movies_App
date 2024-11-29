
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';

class CustomButtonauth extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color? myColor;
  final String iconPath;
  const CustomButtonauth({
    super.key,
    required this.title,
    this.onPressed,
    this.myColor,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: myColor ?? KColors.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
          Image.asset(
            iconPath,
            height: 30,
          ),
        ],
      ),
    );
  }
}
