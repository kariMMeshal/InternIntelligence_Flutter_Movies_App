import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/cashed_image.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/popular_movies_provider.dart';
import 'package:flutter_movie_app_2/features/PopualrScreen/popular_screen.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

Widget popularSection(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Most Popular", style: KCustomTextStyle.sectionsTextStyle()),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PopularMoviesScreen(),
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
        child: Consumer<PopularMovieProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: min(8, provider.popularMovies.length),
                itemBuilder: (context, index) {
                  final movie = provider.popularMovies[index];
                  return InkWell(
                      onTap: () {
                        KHelperFunctions.navigateToMovieDetails(context, movie);
                      },
                      child: Hero(
                          tag: "popular_poster${movie.id}",
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: KCashedImage.customCachedImage(
                                "https://image.tmdb.org/t/p/original${movie.posterPath}"),
                          )));
                });
          },
        ),
      ),
    ],
  );
}
