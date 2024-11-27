import 'package:flutter/material.dart';

class KSlidingButton {
  KSlidingButton._();

  static Container slidingButton(
      {required String title, required bool isActive}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? Colors.red : Colors.transparent, // Border color
            width: 3.0, // Border width
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}
