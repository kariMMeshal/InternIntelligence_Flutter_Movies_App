import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CheckState {
  CheckState._();

  static void getState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      print(user == null
          ? '===== User is currently signed out! ====='
          : '===== User is signed in! ======');
    });
  }

  static Future<bool> isUserSignedIn() async {
    try {
      final googleSignIn = GoogleSignIn();
      return await googleSignIn.isSignedIn() ||
          (FirebaseAuth.instance.currentUser?.emailVerified ?? false);
    } catch (e) {
      print("Error checking sign-in state: $e");
      return false;
    }
  }
}
