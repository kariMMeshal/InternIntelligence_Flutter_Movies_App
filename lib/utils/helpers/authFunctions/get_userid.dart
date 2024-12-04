import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<String?> getUserId() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid; 
    } else {
      
      debugPrint('User is not logged in');
      return null;
    }
  } catch (e) {
    debugPrint('Error getting userId: $e');
    return null;
  }
}
