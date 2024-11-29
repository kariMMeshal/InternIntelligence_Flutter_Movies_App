import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/Auth/Screens/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class KSignOut {
  KSignOut._();

  static void logOut(context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();

    print("======= You are Signed Out  ========");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
