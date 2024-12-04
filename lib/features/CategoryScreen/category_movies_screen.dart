import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/CategoryScreen/providers/category_movies_provider.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class CategoryMoviesScreen extends StatefulWidget {
  final int genreId;
  final String genre;
  const CategoryMoviesScreen(
      {super.key, required this.genreId, required this.genre});

  @override
  State<CategoryMoviesScreen> createState() => _CategoryMoviesScreenState();
}

class _CategoryMoviesScreenState extends State<CategoryMoviesScreen> {
  Future<void> fetchData() async {
    await context
        .read<CategoryMoviesProvider>()
        .fetchMoviesByGenre(widget.genreId);
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
        title: Text("${widget.genre} Movies",
            style: KCustomTextStyle.titleTextStyle()),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body:
          Consumer<CategoryMoviesProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.6,
            ),
            itemCount: provider.categoryMovies.length,
            itemBuilder: (context, index) {
              final movie = provider.categoryMovies[index];
              return InkWell(
                  onTap: () {
                    KHelperFunctions.navigateToMovieDetails(context, movie);
                  },
                  child: Hero(
                      tag: "searched_poster${movie.id}",
                      child: KImageCard.imageCard(
                          imagePath:
                              "https://image.tmdb.org/t/p/original${movie.posterPath}")));
            });
      }),
    );
  }
}
