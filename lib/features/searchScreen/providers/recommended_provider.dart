import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/user_activity_firestore.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class RecommendedProvider with ChangeNotifier {
  final KUserActivityService _userActivityService = KUserActivityService();
  List<Movie> clickedMovies = [];
  List<Movie> recommendedMovies = [];
  bool isLoading = false;

  // Fetch the last 3 clicked movies and update the list
  Future<void> fetchClickedMovies(String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      clickedMovies = await _userActivityService.getClickedMovies(userId);

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching clicked movies: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Add clicked movie to Firestore and update the list
Future<void> addClickedMovie(String userId, Movie movie) async {
  try {
    // Check if the movie is already in the list by comparing its id
    if (!clickedMovies.any((m) => m.id == movie.id)) {
      await _userActivityService.addClickedMovie(userId, movie);

      // Add the movie to the list
      clickedMovies.add(movie);

      // Ensure the list doesn't exceed 3 movies
      if (clickedMovies.length > 3) {
        clickedMovies.removeAt(0); // Remove the oldest movie
      }

      notifyListeners();
    } else {
      debugPrint('Movie is already in the clickedMovies list.');
    }
  } catch (e) {
    debugPrint('Error adding clicked movie: $e');
  }
}


// Fetch movie recommendations based on the clicked movies
  Future<void> fetchMovieRecommendations() async {
    try {
      if (clickedMovies.isEmpty)
        return; // No clicked movies, no need to fetch recommendations

      isLoading = true;
      notifyListeners();

      final List<Movie> tempRecommendedMovies = [];
      // Only fetch recommendations if not already fetched or when clickedMovies change
      for (var movie in clickedMovies) {
        final response = await KHttpHelper.get(
          endpoint: '3/movie/${movie.id}/recommendations?',
          bonusEndpoint: "&api_key=YOUR_API_KEY",
        );

        if (response['results'] != null) {
          final recommendedMoviesList = (response['results'] as List)
              .map((data) => Movie.fromJson(data))
              .toList();
          tempRecommendedMovies.addAll(recommendedMoviesList);
        }
      }

      // Remove duplicates by converting to a set and back to a list
      recommendedMovies = tempRecommendedMovies.toSet().toList();
      debugPrint('Fetched ${recommendedMovies.length} recommendations');
    } catch (e) {
      debugPrint('Error fetching recommendations: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
