import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/animations/fade_transition.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/popular_movies_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/movie_details_page.dart';
import 'package:provider/provider.dart';

class KPopularSection {
  KPopularSection._();

  static Widget popularSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Most Popular", style: KCustomTextStyle.sectionsTextStyle()),
              Text(
                "show all",
                style: KCustomTextStyle.buttonTextStyle(color: Colors.orange),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: Consumer<PopularMovieProvider>(
            builder: (context, provider, child) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.popularMovies.length,
                  itemBuilder: (context, index) {
                    final movie = provider.popularMovies[index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              fadeTransition(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        MovieDetailsPage(
                                            movieId: movie.id.toString())),
                              ));
                        },
                        child: Hero(
                            tag: "popular_poster${movie.id}",
                            child: KImageCard.imageCard(
                                imagePath:
                                    "https://image.tmdb.org/t/p/original${movie.posterPath}")));
                  });
            },
          ),
        ),
      ],
    );
  }
}
