import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/searchScreen/providers/recommended_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

@override
Widget recommendedSection() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recommended For You ",
                style: KCustomTextStyle.titleTextStyle()),
          ],
        ),
      ),
      Consumer<RecommendedProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SizedBox(
            height: 280,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: min(provider.recommendedMovies.length, 10),
                itemBuilder: (context, index) {
                  final movie = provider.recommendedMovies[index];
                  return InkWell(
                      onTap: () {
                        KHelperFunctions.navigateToMovieDetails(context, movie);
                      },
                      child: Hero(
                          tag: "searched_poster${movie.id}",
                          child: KImageCard.imageCard(
                              imagePath:
                                  "https://image.tmdb.org/t/p/original${movie.posterPath}")));
                }),
          );
        },
      ),
    ],
  );
}
