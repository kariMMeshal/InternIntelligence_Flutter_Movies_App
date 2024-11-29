import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';

class KCustomTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  final bool isHidden;
  final Icon icon;
  final Function? suffixOntap;
  final Function? prefixOntap;
  final Function? onSubmit;

  const KCustomTextfield({
    super.key,
    required this.hint,
    required this.myController,
    this.isHidden = false,
    required this.icon,
    this.suffixOntap,
    this.prefixOntap,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
        onFieldSubmitted: (value) {
          onSubmit!();
        },
        obscureText: isHidden,
        controller: myController,
        style: KCustomTextStyle.buttonTextStyle(),
        decoration: InputDecoration(
          prefixIconColor: KColors.white,
          prefixIcon: IconButton(
              onPressed: () {
                prefixOntap!();
              },
              icon: icon),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              suffixOntap!();
            },
          ),
          suffixIconColor: Colors.white,
          filled: true,
          fillColor: KColors.secondary,
          contentPadding: const EdgeInsets.all(12),
          hintText: hint,
          hintStyle: KCustomTextStyle.subTitleTextStyle(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.white, width: 5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.grey, width: 5),
          ),
        ),
      ),
    );
  }
}
