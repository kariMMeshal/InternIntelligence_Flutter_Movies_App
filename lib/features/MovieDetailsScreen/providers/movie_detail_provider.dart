import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/models/movie_model.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class MovieDetailsProvider with ChangeNotifier {
  Movie? movieDetails; // This will store the fetched movie details
  bool isLoading = false;

  Future<void> fetchMovieDetails({required String movieId}) async {
    isLoading = true;
    notifyListeners();

    var endpoint = '3/movie/$movieId?language=en-US&'; //

    final response = await KHttpHelper.get(endpoint: endpoint);
    // print("====================$movieId");
    movieDetails = Movie.fromJson(response);
    isLoading = false;
    notifyListeners();
  }
}

