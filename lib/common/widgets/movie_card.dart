import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/styles/long_text_button.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';

class KMovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onDeleteTap; // Parameter for delete icon onTap

  const KMovieCard({super.key, required this.movie, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: KColors.secondary,
        borderRadius: BorderRadius.circular(25),
      ),
      height: 250,
      child: Row(
        children: [
          SizedBox(
            width: 170,
            height: 250,
            child: KImageCard.imageCard(
              imagePath:
                  "https://image.tmdb.org/t/p/original${movie.posterPath}",
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: KCustomTextStyle.buttonTextStyle(),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              movie.genres!.take(2).join(", "),
                              style: KCustomTextStyle.subTitleTextStyle(),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: KColors.borderSecondary,
                          size: 30,
                        ),
                        onPressed: onDeleteTap,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Runtime: ${movie.runtime! ~/ 60}h ${movie.runtime! % 60}m",
                        style: KCustomTextStyle.subTitleTextStyle(),
                      ),
                      Text(
                        "Memory: 1.2 GB", // Placeholder for memory size
                        style: KCustomTextStyle.subTitleTextStyle(),
                      ),
                      const SizedBox(height: 10),
                      KLongTextButton.longtextButton(
                        ontap: () => KHelperFunctions.navigateToMovieDetails(
                            context, movie),
                        title: "Watch Now ",
                        iconData: Icons.play_arrow,
                        backGroundColor: KColors.buttonPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
