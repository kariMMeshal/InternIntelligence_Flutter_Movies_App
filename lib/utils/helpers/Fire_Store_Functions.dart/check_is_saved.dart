import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkIfMovieIsSaved(String movieId) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      // Get a reference to the user's 'movies' collection
      DocumentReference movieRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('movies')
          .doc(movieId);  // Use the movieId directly here

      // Check if the movie exists in the collection
      DocumentSnapshot movieSnapshot = await movieRef.get();

      return movieSnapshot.exists;  // Return true if the movie exists, else false
    } catch (e) {
      print("Error checking movie save status: $e");
      return false;  // Return false in case of an error
    }
  }
  return false;  // Return false if no user is logged in
}
