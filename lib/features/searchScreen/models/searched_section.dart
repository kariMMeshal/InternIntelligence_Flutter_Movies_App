import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/searchScreen/providers/search_movies_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

Widget searchedMoviesSection() {
  return Column(
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
          if (provider.searchedMovies.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Text(
                "Nope :/ ",
                style: KCustomTextStyle.titleTextStyle(),
              ),
            );
          }

          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.6,
              ),
              itemCount: provider.searchedMovies.length,
              itemBuilder: (context, index) {
                final movie = provider.searchedMovies[index];
                return InkWell(
                    onTap: () {
                      KHelperFunctions.navigateToMovieDetails(context, movie);
                    },
                    child: Hero(
                        tag: "searched_poster${movie.id}",
                        child: KImageCard.imageCard(
                            imagePath:
                                "https://image.tmdb.org/t/p/original${movie.posterPath}")));
              });
        },
      ),
    ],
  );
}
