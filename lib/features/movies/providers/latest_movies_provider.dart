import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/movies/models/movie_model.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class LatestMoviesProvider with ChangeNotifier {
  List<Movie> latestMovies = [];
  bool isLoading = false;

  Future<void> fetchMovies() async {
    isLoading = true;
    const endpoint = '3/trending/movie/day?language=en-US&';
    notifyListeners();

    final response = await KHttpHelper.get(endpoint);

    // Process the response
    latestMovies = (response['results'] as List)
        .map((latestMovies) => Movie.fromJson(latestMovies))
        .toList();
    isLoading = false;
    notifyListeners();
  }
}
