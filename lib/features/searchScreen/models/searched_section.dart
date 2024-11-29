import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/animations/fade_transition.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/movie_details_page.dart';
import 'package:flutter_movie_app_2/features/searchScreen/providers/search_movies_provider.dart';
import 'package:provider/provider.dart';

class KSearchedSection {
  KSearchedSection._();

  static Expanded searchedMoviesSection() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Search Results : ",
                    style: KCustomTextStyle.sectionsTextStyle()),
              ],
            ),
          ),
          Consumer<SearchMoviesProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.6,
                    ),
                    // scrollDirection: Axis.horizontal,
                    itemCount: provider.searchedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = provider.searchedMovies[index];
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              fadeTransition(PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      MovieDetailsPage(
                                          movieId: movie.id.toString()))),
                            );
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
      ),
    );
  }
}
