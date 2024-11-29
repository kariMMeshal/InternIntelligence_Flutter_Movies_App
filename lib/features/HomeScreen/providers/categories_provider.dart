import 'package:flutter/material.dart';

import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class CategoriesProvider with ChangeNotifier {
  List categories = [];
  bool isLoading = false;

  Future<void> fetchMovies() async {
    isLoading = true;
    const endpoint = '3/genre/movie/list?language=en&';
    notifyListeners();

    final response = await KHttpHelper.get(endpoint: endpoint);

    // Process the response
    categories = response["genres"];

    isLoading = false;
    notifyListeners();
  }
}
