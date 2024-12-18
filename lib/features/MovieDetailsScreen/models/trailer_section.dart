import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/cashed_image.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/trailer_provider.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class KTrailerSection {
  KTrailerSection._();

  static Consumer<TrailerProvider> trailerSection() {
    return Consumer<TrailerProvider>(
      builder: (context, trailerProvider, child) {
        // Safe null check for `key`
        if (trailerProvider.key == null) {
          return Container(
            decoration: BoxDecoration(
              color: KColors.secondary,
              borderRadius: BorderRadius.circular(25),
            ),
            width: 450,
            height: 180,
            child: Center(
              child: Text(
                "No Trailer Available :/",
                style: KCustomTextStyle.titleTextStyle(),
              ),
            ),
          );
        }

        // If trailerProvider is not null, proceed with the widget
        return Container(
          decoration: BoxDecoration(
            color: KColors.secondary,
            borderRadius: BorderRadius.circular(25),
          ),
          width: 450,
          height: 180,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    // Safe check for imageUrl
                    trailerProvider.imageUrl != null
                        ? KCashedImage.customCachedImage(trailerProvider.imageUrl!)
                        : const SizedBox.shrink(), // Fallback if imageUrl is null
                    Positioned(
                      bottom: 50,
                      left: 80,
                      child: InkWell(
                        onTap: trailerProvider.videoUrl != null
                            ? () => KHelperFunctions.launchURL(trailerProvider.videoUrl!)
                            : null, // Only launch URL if videoUrl is not null
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Trailer",
                              style: KCustomTextStyle.sectionsTextStyle(),
                            ),
                            const Icon(
                              Icons.download,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          trailerProvider.title ?? 'No title available', // Fallback if title is null
                          style: KCustomTextStyle.subTitleTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
