import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_iconbutton.dart';
import 'package:flutter_movie_app_2/features/SavedScreen/saved_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/add_movie_func.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/delete_movie.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class KPoster {
  KPoster._();

  static Stack poster({
    required Movie? movie,
    required BuildContext context,
    required bool isSaved,
  }) {
    return Stack(
      children: [
        Hero(
          tag: "poster${movie!.id}",
          child: Image.network(
            "https://image.tmdb.org/t/p/original${movie.posterPath}",
            fit: BoxFit.cover,
            width: 500,
            height: 400,
            alignment: Alignment.topCenter,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 50, color: Colors.grey),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 120, // Height of the gradient
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  KColors.primaryBackground.withOpacity(0.8),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: KCustomIconbutton.kiconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            ontap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ),
        Positioned(
          right: 70,
          top: 0,
          child: Consumer<SavedMoviesProvider>(
            builder: (context, provider, child) => KCustomIconbutton.kiconButton(
              icon: provider.isSaved
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_border_rounded),
              ontap: () {
                if (!isSaved) {
                  saveMovieToFirestore(movie.id.toString(), context);
                } else {
                  deleteMovieFromFirestore(movie.id.toString(), context);
                }
              },
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: KCustomIconbutton.kiconButton(
            icon: const Icon(Icons.ios_share_rounded),
            ontap: () {},
          ),
        ),
      ],
    );
  }
}
