import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> deleteMovieFromFirestore(String movieId) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      CollectionReference moviesRef = userDocRef.collection('movies');

      // Delete the movie document by its ID
      await moviesRef.doc(movieId).delete();

      print("Movie data deleted from Firestore!");
    } catch (e) {
      print("Error deleting movie data: $e");
    }
  }
}
