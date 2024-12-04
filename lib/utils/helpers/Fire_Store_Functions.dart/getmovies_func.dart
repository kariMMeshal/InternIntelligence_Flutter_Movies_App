import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';

Future<List<Movie>> getMoviesFromFirestore() async {
  User? user = FirebaseAuth.instance.currentUser;
  List<Movie> savedMoviesList = [];

  if (user != null) {
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      CollectionReference moviesRef = userDocRef.collection('movies');

      QuerySnapshot snapshot = await moviesRef.get();

      // Loop through the query results and convert them to Movie objects
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Movie movie = Movie(
          id: data['id'],
          title: data['title'],
          posterPath: data['posterPath'],
          description: data['description'],
          releaseDate: data['releaseDate'],
          rating: data['rating'],
          genres:
              List<String>.from(data['genres'] ?? []), // Safely parse genres
          runtime: data['runtime'],
        );

        // Add the movie to the list
        savedMoviesList.add(movie);
      }

      // print("Movies fetched from Firestore!");
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  return savedMoviesList;
}
