import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class PopularMovieProvider with ChangeNotifier {
  List<Movie> popularMovies = [];
  bool isLoading = false;

  Future<void> fetchMovies() async {
    isLoading = true;
    const endpoint = '3/movie/popular?language=en-US&page=1&';
    notifyListeners();

    final response = await KHttpHelper.get(endpoint: endpoint);

    popularMovies = (response['results'] as List)
        .map((popularMovies) => Movie.fromJson(popularMovies))
        .toList();

    isLoading = false;
    notifyListeners();
  }
}
