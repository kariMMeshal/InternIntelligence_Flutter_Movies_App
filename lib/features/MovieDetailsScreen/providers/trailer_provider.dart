// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter_movie_app_2/utils/https/http_client.dart';

class TrailerProvider extends ChangeNotifier {
  String? title;
  String? key;
  String? imageUrl;
  String? videoUrl;
  bool isLoading = false;

  // Method to fetch trailer data
  Future<void> fetchTrailerData({required String movieId}) async {
    final endpoint = '3/movie/$movieId/videos?';
    isLoading = true;
    notifyListeners();

    try {
      isLoading = true;
      notifyListeners();
      final trailerData = await KHttpHelper.get(endpoint: endpoint);
      int lastIndex = trailerData["results"].length;
      int trailerIndex = 0;
      for (int i = 0; i < lastIndex; i++) {
        if (trailerData["results"][i]["type"] == "Trailer") {
          trailerIndex = i;
          break;
        }
      }
      key = trailerData["results"][trailerIndex]["key"];
      title = trailerData["results"][trailerIndex]["name"];
      imageUrl = "https://img.youtube.com/vi/$key/hqdefault.jpg";
      videoUrl = "https://www.youtube.com/watch?v=$key";
      isLoading = true;
      notifyListeners();
    } catch (error) {
      print("----- error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
