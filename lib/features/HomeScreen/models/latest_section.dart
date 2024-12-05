import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/cashed_image.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/latest_movies_provider.dart';
import 'package:flutter_movie_app_2/features/LatestScreen/latest_movies_screen.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

Widget latestSection(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20 ,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Latest Movies", style: KCustomTextStyle.sectionsTextStyle()),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LatestMoviesScreen(),
                    ),
                  );
                },
                child: Text(
                  "show More",
                  style: KCustomTextStyle.buttonTextStyle(color: Colors.orange),
                )),
          ],
        ),
      ),
      SizedBox(
        height: 280,
        child: Consumer<LatestMoviesProvider>(
          builder: (context, latestMoviesProvider, child) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: min(8, latestMoviesProvider.latestMovies.length),
              itemBuilder: (context, index) {
                final latestMovie = latestMoviesProvider.latestMovies[index];
                return InkWell(
                    onTap: () {
                      KHelperFunctions.navigateToMovieDetails(
                          context, latestMovie);
                    },
                    child: Hero(
                        tag: "latest_poster${latestMovie.id}",
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: KCashedImage.customCachedImage(
                              "https://image.tmdb.org/t/p/original${latestMovie.posterPath}"),
                        )));
              },
            );
          },
        ),
      ),
    ],
  );
}
