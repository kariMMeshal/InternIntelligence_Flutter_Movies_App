import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class SearchMoviesProvider with ChangeNotifier {
  List<Movie> searchedMovies = [];
  bool isLoading = false;

  Future<void> fetchMovies({required String searchText}) async {
    isLoading = true;
    notifyListeners();

    if (searchText.trim().isEmpty) {
      searchedMovies = [];
      isLoading = false;
      notifyListeners();
      return;
    }

    const endpoint = '3/search/movie?';
    final bonusEndpoint = '&query=${searchText.trim()}';

    try {
      final response = await KHttpHelper.get(
          endpoint: endpoint, bonusEndpoint: bonusEndpoint);

      if (response['results'] is List) {
        searchedMovies = (response['results'] as List)
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
      } else {
        searchedMovies = [];
      }
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      searchedMovies = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
