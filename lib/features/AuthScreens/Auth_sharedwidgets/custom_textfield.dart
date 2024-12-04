import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  final bool isHidden;
  const CustomTextfield({
    super.key,
    required this.hint,
    required this.myController,
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        obscureText: isHidden,
        validator: (val) {
          if (val == "") {
            return "Can't be Empty ";
          }
          return null;
        },
        controller: myController,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.all(15),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 20, color: Colors.grey),
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
