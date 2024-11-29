import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/animations/fade_transition.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/movie_details_page.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/similar_provider.dart';
import 'package:provider/provider.dart';

class KSimilarSection {
  KSimilarSection._();

  static Consumer<SimilarProvider> similarSection() {
    return Consumer<SimilarProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.similarMovies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.6),
            itemBuilder: (context, index) {
              final movie = provider.similarMovies[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      fadeTransition(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MovieDetailsPage(
                                    movieId: movie.id.toString(),
                                  ))));
                },
                child: KImageCard.imageCard(
                  imagePath:
                      "https://image.tmdb.org/t/p/original${movie.posterPath}",
                ),
              );
            },
          ),
        );
      },
    );
  }
}
