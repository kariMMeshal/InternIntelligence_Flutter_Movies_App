import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/shared_prefs_helper.dart'; // Import SharedPrefs helper

class ChangeUsernameDialog extends StatelessWidget {
  final TextEditingController _controller;

  ChangeUsernameDialog({super.key, required String currentUserName})
      : _controller = TextEditingController(text: currentUserName);

  void _updateUsername(BuildContext context) async {
    final newUsername = _controller.text.trim();
    if (newUsername.isNotEmpty) {
      // Update Firebase user display name
      await FirebaseAuth.instance.currentUser?.updateDisplayName(newUsername);

      // Update SharedPreferences
      await KSharedPrefsHelper.saveString("userName", newUsername);

      Navigator.of(context).pop(newUsername);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username cannot be empty")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: KColors.primaryBackground,
      title: Text(
        "Change Username",
        style: KCustomTextStyle.sectionsTextStyle(),
      ),
      content: TextField(
          style: KCustomTextStyle.buttonTextStyle(),
          controller: _controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: KColors.secondary,
              hintText: _controller.text,
              hintStyle: KCustomTextStyle.subTitleTextStyle())),
      actions: [
        TextButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(KColors.buttonSecondary)),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            )),
        ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(KColors.secondary),
            ),
            onPressed: () => _updateUsername(context),
            child: const Text("Save"))
      ],
    );
  }
}
