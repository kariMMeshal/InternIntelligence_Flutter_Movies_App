import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/getdata_func.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';

class SavedMoviesProvider with ChangeNotifier {
  List<Movie> savedMovies = [];

  Future<void> fetchSaved() async {
    savedMovies = await getMoviesFromFirestore();
  }

  void addMovie(Movie movie) {
    savedMovies.add(movie);
    notifyListeners();
  }

  void removeMovie(String movieId) {
    savedMovies.removeWhere((movie) => movie.id.toString() == movieId);
    notifyListeners();
  }
}
