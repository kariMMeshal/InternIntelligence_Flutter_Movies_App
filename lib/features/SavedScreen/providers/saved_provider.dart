import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/add_movie_func.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/delete_movie.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/getdata_func.dart';
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

  void addMovie(Movie movie) {
    saveMovieToFirestore(movie);
    savedMovies.add(movie);
    notifyListeners();
  }

  void removeMovie(String movieId) {
    deleteMovieFromFirestore(movieId);
    savedMovies.removeWhere((movie) => movie.id.toString() == movieId);
    notifyListeners();
  }
}
