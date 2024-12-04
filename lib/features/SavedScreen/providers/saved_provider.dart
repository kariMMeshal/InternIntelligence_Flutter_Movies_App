import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/add_movie_func.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/delete_movie.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/getmovies_func.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';

class SavedMoviesProvider with ChangeNotifier {
  List<Movie> savedMovies = [];
  bool isLoading = false;

  Future<void> fetchSaved() async {
    isLoading = true;
    notifyListeners();
    savedMovies = await getMoviesFromFirestore();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addMovie(Movie movie) async {
    await saveMovieToFirestore(movie);
    savedMovies.add(movie);
    notifyListeners();
  }

  Future<void> removeMovie(String movieId) async {
    await deleteMovieFromFirestore(movieId);
    savedMovies.removeWhere((movie) => movie.id.toString() == movieId);
    notifyListeners();
  }
}
