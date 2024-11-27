import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/movies/models/movie_model.dart';

import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class TopRatedMovieProvider with ChangeNotifier {
  List<Movie> topRatedMovies = [];
  bool isLoading = false;

  Future<void> fetchMovies() async {
    isLoading = true;
    const endpoint = '3/movie/top_rated?language=en-US&page=1&';
    notifyListeners();

    final response = await KHttpHelper.get(endpoint);

    // Process the response
    topRatedMovies = (response['results'] as List)
        .map((topRatedMovies) => Movie.fromJson(topRatedMovies))
        .toList();

    isLoading = false;
    notifyListeners();
  }
}
