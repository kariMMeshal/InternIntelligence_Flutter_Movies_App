// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter_movie_app_2/features/movies/models/trailer_model.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class TrailerProvider extends ChangeNotifier {
  List<Trailer> trailers = [];
  bool isLoading = false;

  // Method to fetch trailer data
  Future<void> fetchTrailerData({required String movieId}) async {
    final endpoint = '3/movie/$movieId/videos?';
    isLoading = true;
    notifyListeners();

    try {
      final trailerData = await KHttpHelper.get(endpoint);

      trailers = (trailerData['results'] as List)
          .map((item) => Trailer.fromJson(item))
          .toList();
    } catch (error) {
      print("----- error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
