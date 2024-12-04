import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> checkIfMovieIsSaved(String movieId) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      DocumentReference movieRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('movies')
          .doc(movieId);

      DocumentSnapshot movieSnapshot = await movieRef.get();

      return movieSnapshot.exists;
    } catch (e) {
      debugPrint("Error checking movie save status: $e");
      return false;
    }
  }
  return false;
}
