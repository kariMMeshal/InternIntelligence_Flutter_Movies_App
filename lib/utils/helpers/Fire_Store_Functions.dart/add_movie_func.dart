import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/SavedScreen/providers/saved_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/check_is_saved.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/movie_detail_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:provider/provider.dart';

Future<void> saveMovieToFirestore(String movieId, BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;
  bool isSaved = false;
  print("saveing....>.....>");

  if (user != null) {
    try {
      var movieDetails = context.read<MovieDetailsProvider>().movieDetails;

      if (movieDetails == null) {
        debugPrint("Movie details are not available!");
        return;
      }

      // Check if the movie is already saved using movieId
      isSaved = await checkIfMovieIsSaved(movieId);
      print(isSaved);
      if (isSaved) {
        print("Movie is already saved!");
        return;
      }

      DocumentReference movieRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('movies')
          .doc(movieId);

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
      Movie movie = Movie(
        id: movieDetails.id,
        title: movieDetails.title,
        posterPath: movieDetails.posterPath,
        description: movieDetails.description,
        releaseDate: movieDetails.releaseDate,
        rating: movieDetails.rating,
        genres:
            List<String>.from(movieDetails.genres ?? []), // Safely parse genres
        runtime: movieDetails.runtime,
      );

      await movieRef.set(movieData);

      context.read<SavedMoviesProvider>().addMovie(movie);

      print("Movie saved to Firestore!");
    } catch (e) {
      print("Error saving movie: $e");
    }
  }
}
