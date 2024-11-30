import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_button_style.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/styles/long_text_button.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_iconbutton.dart';
import 'package:flutter_movie_app_2/common/widgets/sliding_button.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/models/similar_section.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/models/trailer_section.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/movie_detail_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/similar_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/trailer_provider.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/add_movie_func.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/check_is_saved.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/delete_movie.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final String movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsPage> {
  int activeButton = 0;
  bool isSaved = false;
  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MovieDetailsProvider>()
          .fetchMovieDetails(movieId: widget.movieId);
      context.read<SimilarProvider>().fetchMovies(movieId: widget.movieId);
      context.read<TrailerProvider>().fetchTrailerData(movieId: widget.movieId);
    });
  }

  Future<void> checkMovieStatus() async {
    isSaved = await checkIfMovieIsSaved(widget.movieId);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    checkMovieStatus();
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
              Stack(
                children: [
                  Hero(
                    tag: "poster${movie!.id}",
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original${movie.posterPath}",
                      fit: BoxFit.cover,
                      width: 500,
                      height: 400,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey),
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
                    child: KCustomIconbutton.kiconButton(
                      icon: isSaved
                          ? const Icon(Icons.bookmark)
                          : const Icon(Icons.bookmark_border_rounded),
                      ontap: () async {
                        if (isSaved) {
                          isSaved = !isSaved;
                          await deleteMovieFromFirestore(
                              movie.id.toString(), context);
                        } else {
                          isSaved = !isSaved;
                          await saveMovieToFirestore(
                              movie.id.toString(), context);
                        }
                        setState(() {});
                      },
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
              ),
              Column(
                children: [
                  Text(
                    movie.title,
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
                      KLongTextButton.longtextButton(
                        title: "Play",
                        iconData: Icons.play_arrow,
                        backGroundColor: Colors.red,
                      ),
                      KLongTextButton.longtextButton(
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
