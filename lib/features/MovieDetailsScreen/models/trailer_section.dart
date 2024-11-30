import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/trailer_provider.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class KTrailerSection {
  KTrailerSection._();

  static Consumer<TrailerProvider> trailerSection() {
    return Consumer<TrailerProvider>(
      builder: (context, trailerProvider, child) {
        return Container(
          decoration: BoxDecoration(
              color: KColors.secondary,
              borderRadius: BorderRadius.circular(25)),
          width: 400,
          height: 180,
          child: trailerProvider.key != ""
              ? Row(
                  children: [
                    Stack(
                      children: [
                        KImageCard.imageCard(
                          imagePath: trailerProvider.imageUrl!,
                        ),
                        Positioned(
                          bottom: 50,
                          left: 80,
                          child: InkWell(
                            onTap: () => KHelperFunctions.launchURL(
                                trailerProvider.videoUrl!),
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
                              trailerProvider.title!,
                              style: KCustomTextStyle.subTitleTextStyle(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Center(
                  child: Text("No Trailer availabe :/",
                      style: KCustomTextStyle.titleTextStyle())),
        );
      },
    );
  }
}
