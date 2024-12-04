import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';

class KUserActivityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add clicked movie to Firestore
  Future<void> addClickedMovie(String userId, Movie movie) async {
    final clickedMoviesRef =
        _firestore.collection('users').doc(userId).collection('clickedMovies');

    await clickedMoviesRef.add({
      'movieId': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'description': movie.description,
      'releaseDate': movie.releaseDate,
      'rating': movie.rating,
      'genres': movie.genres,
      'runtime': movie.runtime,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Order them and Remove the oldest movie if more than 3
    final clickedMovies = await clickedMoviesRef.orderBy('timestamp').get();
    if (clickedMovies.docs.length > 3) {
      await clickedMovies.docs.first.reference.delete();
    }
    debugPrint("Movie added to Clicked Movies ----- ");
  }

  // Get clicked movies from Firestore
  Future<List<Movie>> getClickedMovies(String userId) async {
    final clickedMoviesSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('clickedMovies')
        .orderBy('timestamp')
        .get();
    List<Movie> clickedMovies = clickedMoviesSnapshot.docs
        .map((doc) => Movie(
              id: doc['movieId'],
              title: doc['title'],
              posterPath: doc['posterPath'],
              description: doc['description'],
              releaseDate: doc['releaseDate'],
              rating: doc['rating'].toDouble(),
              genres: List<String>.from(doc['genres'] ?? []),
              runtime: doc['runtime'],
            ))
        .toList();
    return clickedMovies;
  }
}
