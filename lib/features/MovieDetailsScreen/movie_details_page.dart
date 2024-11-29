import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_button_style.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/sliding_button.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/models/poster.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/models/similar_section.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/models/trailer_section.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/movie_detail_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/similar_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/trailer_provider.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final String movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsPage> {
  int activeButton = 0;
  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MovieDetailsProvider>()
          .fetchMovieDetails(movieId: widget.movieId);
      context.read<SimilarProvider>().fetchMovies(movieId: widget.movieId);
      context.read<TrailerProvider>().fetchTrailerData(movieId: widget.movieId);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.primaryBackground,
      body: Consumer<MovieDetailsProvider>(
        builder: (context, provider, child) {
          var movie = provider.movieDetails;

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              // Stack for the Image
              KPoster.poster(movie, context),
              Column(
                children: [
                  Text(
                    movie!.title,
                    style: KCustomTextStyle.titleTextStyle(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${movie.releaseDate.substring(0, 4)} | ",
                        style: KCustomTextStyle.subTitleTextStyle(),
                      ),
                      Text(
                        movie.genres!.join(","),
                        style: KCustomTextStyle.subTitleTextStyle(),
                      ),
                      Text(
                        " | ${movie.runtime! ~/ 60}h ${movie.runtime! % 60}m",
                        style: KCustomTextStyle.subTitleTextStyle(),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KCustomButtonStyle.longtextButton(
                        title: "Play",
                        iconData: Icons.play_arrow,
                        backGroundColor: Colors.red,
                      ),
                      KCustomButtonStyle.longtextButton(
                        title: "Download",
                        iconData: Icons.download,
                        backGroundColor: Colors.grey,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "${movie.description}...",
                      style: KCustomTextStyle.subTitleTextStyle(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          activeButton = 0;
                          setState(() {});
                        },
                        child: KSlidingButton.slidingButton(
                          title: "Episode",
                          isActive: activeButton == 0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          activeButton = 1;
                          setState(() {});
                        },
                        child: KSlidingButton.slidingButton(
                          title: "Similar",
                          isActive: activeButton == 1,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          activeButton = 2;
                          setState(() {});
                        },
                        child: KSlidingButton.slidingButton(
                          title: "About",
                          isActive: activeButton == 2,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: activeButton == 0
                        ? KTrailerSection.trailerSection()
                        : activeButton == 1
                            ? KSimilarSection.similarSection()
                            : Column(
                                children: [
                                  Text(
                                    movie.description,
                                    style: KCustomTextStyle.subTitleTextStyle(),
                                  ),
                                ],
                              ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
