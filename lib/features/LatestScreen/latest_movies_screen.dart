import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/cashed_image.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/latest_movies_provider.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class LatestMoviesScreen extends StatefulWidget {
  const LatestMoviesScreen({super.key});

  @override
  State<LatestMoviesScreen> createState() => _LatestMoviesScreenState();
}

class _LatestMoviesScreenState extends State<LatestMoviesScreen> {
  Future<void> fetchData() async {
    await context.read<LatestMoviesProvider>().fetchMovies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.primaryBackground,
      appBar: AppBar(
        title: Text("Latest Movies", style: KCustomTextStyle.titleTextStyle()),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Consumer<LatestMoviesProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.6,
            ),
            itemCount: provider.latestMovies.length,
            itemBuilder: (context, index) {
              final movie = provider.latestMovies[index];
              return InkWell(
                  onTap: () {
                    KHelperFunctions.navigateToMovieDetails(context, movie);
                  },
                  child: Hero(
                      tag: "searched_poster${movie.id}",
                      child: KCashedImage.customCachedImage(
                          "https://image.tmdb.org/t/p/original${movie.posterPath}")));
            });
      }),
    );
  }
}
