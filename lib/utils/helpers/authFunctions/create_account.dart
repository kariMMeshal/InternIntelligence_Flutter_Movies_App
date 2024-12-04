import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/AuthScreens/Auth_sharedwidgets/custom_dialog.dart';
import 'package:flutter_movie_app_2/features/AuthScreens/Screens/login_page.dart';

class KCreateAccount {
  KCreateAccount._();

  // Loading function to show a loading dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  // Function to dismiss the loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<void> createAccount(
    BuildContext context, {
    required String emailAddress,
    required String password,
    required String userName,
  }) async {
    try {
      // Show loading dialog
      showLoadingDialog(context);

      // Create the user
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Update the display name
      await credential.user!.updateDisplayName(userName);

      // Send email verification
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
      }

      hideLoadingDialog(context);

      // Show success dialog
      KCustomDialog(
        context: context,
        title: "Verification",
        message:
            'A verification email has been sent to your email. Please verify and then log in.',
        dialogType: DialogType.info,
        btnOkOnPress: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        },
      ).customDialog();
    } on FirebaseAuthException catch (e) {
      // Dismiss the loading dialog
      hideLoadingDialog(context);

      // Handle Firebase-specific errors
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }

      // Show error dialog
      KCustomDialog(
        context: context,
        title: "Error",
        message: errorMessage,
        dialogType: DialogType.error,
      ).customDialog();
    } catch (e) {
      // Dismiss the loading dialog
      hideLoadingDialog(context);

      // General error handling
      KCustomDialog(
        context: context,
        title: "Error",
        message: "An unexpected error occurred: ${e.toString()}",
        dialogType: DialogType.error,
      ).customDialog();
    }
  }
}
