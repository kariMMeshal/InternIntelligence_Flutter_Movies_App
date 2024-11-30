import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/SavedScreen/saved_provider.dart';
import 'package:provider/provider.dart';

Future<void> deleteMovieFromFirestore(
    String movieId, BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      // Get a reference to the user's document in Firestore
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Get a reference to the movies subcollection within the user's document
      CollectionReference moviesRef = userDocRef.collection('movies');

      // Delete the movie document by its ID
      await moviesRef.doc(movieId).delete();
      SavedMoviesProvider savedMoviesProvider =
          context.read<SavedMoviesProvider>();

      // Remove the movie from the local saved movies list using the movieId
      savedMoviesProvider.removeMovie(movieId);
      print("Movie data deleted from Firestore!");
    } catch (e) {
      print("Error deleting movie data: $e");
    }
  }
}
