import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class SimilarProvider with ChangeNotifier {
  List<Movie> similarMovies = [];
  bool isLoading = false;

  Future<void> fetchMovies({required String movieId}) async {
    isLoading = true;
    var endpoint = '3/movie/$movieId/similar?';
    notifyListeners();

    final response = await KHttpHelper.get(endpoint: endpoint);

    // Process the response
    similarMovies = (response['results'] as List)
        .map((similarMovies) => Movie.fromJson(similarMovies))
        .toList();

    isLoading = false;
    notifyListeners();
  }
}
