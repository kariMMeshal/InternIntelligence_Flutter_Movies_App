import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/SavedScreen/saved_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/check_is_saved.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/movie_detail_provider.dart';
import 'package:provider/provider.dart';

Future<void> saveMovieToFirestore(String movieId, BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      // Fetch the movie details using the movieId from MovieDetailsProvider
      var movieDetails = context.read<MovieDetailsProvider>().movieDetails;

      if (movieDetails == null) {
        // If the movie details are not yet loaded, fetch the movie details
        await context
            .read<MovieDetailsProvider>()
            .fetchMovieDetails(movieId: movieId);
        movieDetails = context.read<MovieDetailsProvider>().movieDetails;
      }

      if (movieDetails == null) {
        print("Movie details are not available!");
        return;
      }

      // Check if the movie is already saved using movieId
      bool isSaved = await checkIfMovieIsSaved(movieId);
      print(isSaved);
      if (isSaved) {
        print("Movie is already saved!");
        return;
      }

      // If the movie is not saved, proceed to save it
      DocumentReference movieRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('movies')
          .doc(movieId); // Save using movieId

      // Movie data to store
      Map<String, dynamic> movieData = {
        'id': movieDetails.id,
        'title': movieDetails.title,
        'posterPath': movieDetails.posterPath,
        'description': movieDetails.description,
        'releaseDate': movieDetails.releaseDate,
        'rating': movieDetails.rating,
        'genres': movieDetails.genres,
        'runtime': movieDetails.runtime,
      };

      // Save movie to Firestore
      await movieRef.set(movieData);


      // After saving the movie to Firestore, update the UI
      context.read<SavedMoviesProvider>().addMovie(movieData);

      print("Movie saved to Firestore!");
    } catch (e) {
      print("Error saving movie: $e");
    }
  }
}
