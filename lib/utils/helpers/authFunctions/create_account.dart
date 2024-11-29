// ignore_for_file: unused_local_variable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/Auth/Auth_sharedwidgets/custom_dialog.dart';
import 'package:flutter_movie_app_2/features/Auth/Screens/login_page.dart';

class KCreateAccount {
  KCreateAccount._();

  static void createAccount(context,
      {required String emailAddress, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
      }
      KCustomDialog(
        context: context,
        title: "Verification",
        message:
            'an Verification Email has been sent to your email please verify then login',
        dialogType: DialogType.info,
        btnOkOnPress: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
      ).customDialog();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        KCustomDialog(
          context: context,
          title: "Erorr",
          message: 'The password provided is too weak.n',
          dialogType: DialogType.error,
        ).customDialog();
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        KCustomDialog(
          context: context,
          title: "Erorr",
          message: 'The account already exists for that email.',
          dialogType: DialogType.error,
        ).customDialog();
      }
    } catch (e) {
      // print(e);
    }
  }
}
