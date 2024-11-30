import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/check_is_saved.dart';

class SavedMoviesProvider with ChangeNotifier {
  List<Map<String, dynamic>> savedMovies = [];
  bool isSaved = false;
  // Method to add a new movie to the list
  Future<void> addMovie(Map<String, dynamic> movieData) async {
    isSaved = true;

    if (!isSaved) {
      savedMovies.add(movieData); // Add the movie to the local list
      notifyListeners(); // Notify listeners that the data has changed
      print("Notify Listened !");
    } else {
      print("Movie is already saved in Firestore!");
    }
  }

  // Method to remove a saved movie
  void removeMovie(String movieId) {
    isSaved = false;
    savedMovies.removeWhere((movie) => movie['id'] == movieId);
    notifyListeners(); // Notify listeners that the data has changed
  }
}
