import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/widgets/cashed_image.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/popular_movies_provider.dart';
import 'package:provider/provider.dart';

class KImageSlider {
  KImageSlider._();

  static Widget moviesSlider() {
    return Consumer<PopularMovieProvider>(
      builder: (context, provider, child) {
        final movies = provider.popularMovies;

        return CarouselSlider(
          options: CarouselOptions(
            height: 500.0,
            autoPlay: true,
            autoPlayCurve: Curves.linearToEaseOut,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 10),
          ),
          items: List.generate(movies.length, (i) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: KCashedImage.customCachedImage(
                          "https://image.tmdb.org/t/p/original${movies[i].posterPath}"),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
