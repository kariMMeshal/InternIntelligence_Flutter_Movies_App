import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/animations/fade_transition.dart';
import 'package:flutter_movie_app_2/common/widgets/cashed_image.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/movie_details_page.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/similar_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/user_activity_firestore.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/get_userid.dart';
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
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              final movie = provider.similarMovies[index];

              // Safe null check for posterPath
              final posterPath = movie.posterPath;
              final imageUrl = posterPath != null
                  ? "https://image.tmdb.org/t/p/original$posterPath"
                  : ''; // Fallback if posterPath is null

              return InkWell(
                onTap: () async {
                  String? userId = await getUserId();
                  if (userId != null) {
                    KUserActivityService().addClickedMovie(userId, movie);
                    Navigator.pushReplacement(
                      context,
                      fadeTransition(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MovieDetailsPage(
                              movieId: movie.id.toString(),
                            ),
                      )),
                    );
                  }
                },
                child: KCashedImage.customCachedImage(imageUrl),
              );
            },
          ),
        );
      },
    );
  }
}
