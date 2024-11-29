import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_iconbutton.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/models/movie_model.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';

class KPoster {
  KPoster._();

  static Stack poster(Movie? movie, BuildContext context) {
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
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          right: 70,
          top: 0,
          child: KCustomIconbutton.kiconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            ontap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: KCustomIconbutton.kiconButton(
            icon: const Icon(Icons.ios_share_rounded),
            ontap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
