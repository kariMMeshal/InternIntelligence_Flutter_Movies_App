import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/models/movie_model.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class SearchMoviesProvider with ChangeNotifier {
  List<Movie> searchedMovies = [];
  bool isLoading = false;

  Future<void> fetchMovies({required String searchText}) async {
    isLoading = true;
    const endpoint = '3/search/movie?';
    var bonusEndpoint = '&query=$searchText';

    notifyListeners();

    final response =
        await KHttpHelper.get(endpoint: endpoint, bonusEndpoint: bonusEndpoint);

    // Process the response
    searchedMovies = (response['results'] as List)
        .map((searchedMovies) => Movie.fromJson(searchedMovies))
        .toList();

    isLoading = false;
    notifyListeners();
  }
}
