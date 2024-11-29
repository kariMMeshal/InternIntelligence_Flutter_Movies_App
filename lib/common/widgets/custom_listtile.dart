import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';

class KCustomListTile {
  KCustomListTile._();

  static Container customListTile(
      {required String title,
      required IconData icon,
      bool isSeleted = false,
      Function? ontap}) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
          color: isSeleted ? Colors.grey.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(25)),
      child: ListTile(
        onTap: () {
          ontap!();
        },
        trailing: const Icon(Icons.arrow_forward_ios),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50)),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: KCustomTextStyle.buttonTextStyle()),
      ),
    );
  }
}
