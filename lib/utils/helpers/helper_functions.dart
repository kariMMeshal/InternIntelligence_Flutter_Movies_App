// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/animations/fade_transition.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/movie_details_page.dart';
import 'package:flutter_movie_app_2/features/searchScreen/providers/recommended_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/get_userid.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class KHelperFunctions {
  static Color? getColor(String value) {
    value = value.toLowerCase();

    // Define a comprehensive color map.
    Map<String, Color> colorMap = {
      'red': Colors.red,
      'green': Colors.green,
      'blue': Colors.blue,
      'yellow': Colors.yellow,
      'orange': Colors.orange,
      'purple': Colors.purple,
      'pink': Colors.pink,
      'brown': Colors.brown,
      'grey': Colors.grey,
      'black': Colors.black,
      'white': Colors.white,
      'cyan': Colors.cyan,
      'indigo': Colors.indigo,
      'teal': Colors.teal,
      'lime': Colors.lime,
      'amber': Colors.amber,
      'deep orange': Colors.deepOrange,
      'deep purple': Colors.deepPurple,
      'light blue': Colors.lightBlue,
      'light green': Colors.lightGreen,
      'blue grey': Colors.blueGrey,
    };

    // Return the color if it exists in the map; otherwise, return null.
    return colorMap[value];
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop,
                child: const Text("OK")),
          ],
        );
      },
    );
  }

  static Future<void> navigateToMovieDetails(
    BuildContext context,
    Movie movie,
  ) async {
    String? userId = await getUserId();

    if (userId != null) {
      await Provider.of<RecommendedProvider>(context, listen: false)
          .addClickedMovie(userId, movie);
    }

    Navigator.push(
      context,
      fadeTransition(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MovieDetailsPage(movieId: movie.id.toString()),
        ),
      ),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return "${text.substring(0, maxLength)}....";
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime data,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(data);
  }

  static List<K> removeDuplicates<K>(List<K> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrabbedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrabbedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrabbedList;
  }

  static Future<void> launchURL(String url) async {
    Uri _url = Uri.parse(url);
    // await launchUrl(_url);
    // Check if the URL can be launched
    try {
      await launchUrl(_url);
    } catch (e) {
      rethrow;
    }
  }
}
