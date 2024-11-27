import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_iconbutton.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/common/widgets/sliding_button.dart';
import 'package:flutter_movie_app_2/features/movies/providers/movie_detail_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/trailer_provider.dart';
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
  @override
  void initState() {
    super.initState();
    context
        .read<MovieDetailsProvider>()
        .fetchMovieDetails(movieId: widget.movieId);
    context.read<TrailerProvider>().fetchTrailerData(movieId: widget.movieId);
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
                  Image.network(
                    "https://image.tmdb.org/t/p/original${movie!.posterPath}",
                    fit: BoxFit.cover,
                    width: 500,
                    height: 400,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey),
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
              ),
              Expanded(
                child: Column(
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
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              KColors.buttonPrimary,
                            ),
                            minimumSize: WidgetStateProperty.all(
                              const Size(180, 50),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.play_arrow_rounded,
                                  color: Colors.white),
                              Text(
                                "Play",
                                style: KCustomTextStyle.subTitleTextStyle(),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              KColors.secondary,
                            ),
                            minimumSize: WidgetStateProperty.all(
                              const Size(180, 50),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.download, color: Colors.white),
                              Text(
                                "Download",
                                style: KCustomTextStyle.subTitleTextStyle(),
                              ),
                            ],
                          ),
                        ),
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
                          ? Consumer<TrailerProvider>(
                              builder: (context, trailerProvider, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: KColors.secondary,
                                      borderRadius: BorderRadius.circular(25)),
                                  width: 400,
                                  height: 180,
                                  child: trailerProvider.trailers.isNotEmpty
                                      ? Row(
                                          children: [
                                            Stack(
                                              children: [
                                                KImageCard.imageCard(
                                                  imagePath: trailerProvider
                                                      .trailers[0].imageUrl,
                                                ),
                                                const Positioned(
                                                  bottom: 70,
                                                  left: 90,
                                                  child: Icon(
                                                    Icons.play_arrow_rounded,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, right: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Trailer",
                                                          style: KCustomTextStyle
                                                              .buttonTextStyle(),
                                                        ),
                                                        const Icon(
                                                          Icons.download,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: Text(
                                                      trailerProvider
                                                          .trailers[0].name,
                                                      style: KCustomTextStyle
                                                          .subTitleTextStyle(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      : Center(
                                          child: Text("No Trailer availabe :/",
                                              style: KCustomTextStyle
                                                  .titleTextStyle())),
                                );
                              },
                            )
                          : activeButton == 1
                              ? Text(
                                  "Similar Movies Content Here",
                                  style: KCustomTextStyle.subTitleTextStyle(),
                                )
                              : Column(
                                  children: [
                                    Text(
                                      movie.description,
                                      style:
                                          KCustomTextStyle.subTitleTextStyle(),
                                    ),
                                  ],
                                ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
