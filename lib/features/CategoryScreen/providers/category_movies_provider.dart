import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class CategoryMoviesProvider with ChangeNotifier {
  List<Movie> categoryMovies = [];
  bool isLoading = false;

  // Fetch movies for a given genre ID
  Future<void> fetchMoviesByGenre(int genreId) async {
    isLoading = true;
    const endpoint = '3/discover/movie?';
    final bonusEndPoint = '&with_genres=$genreId';

    notifyListeners();

    try {
      final response = await KHttpHelper.get(
          endpoint: endpoint, bonusEndpoint: bonusEndPoint);

      categoryMovies = (response['results'] as List)
          .map((movieData) => Movie.fromJson(movieData))
          .toList();
    } catch (e) {
      debugPrint('Error fetching category movies: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
