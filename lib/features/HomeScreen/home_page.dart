import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_button_style.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_slider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/models/latest_section.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/models/popular_section.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/categories_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/latest_movies_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/popular_movies_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/toprated_movie_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PopularMovieProvider>().fetchMovies();
      context.read<TopRatedMovieProvider>().fetchMovies();
      context.read<CategoriesProvider>().fetchMovies();
      context.read<LatestMoviesProvider>().fetchMovies();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        KImageSlider.moviesSlider(),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, bottom: 10),
          child: Text(
            "Categories",
            style: KCustomTextStyle.sectionsTextStyle(),
          ),
        ),
        SizedBox(
          height: 40,
          child: Consumer<CategoriesProvider>(
            builder: (context, categoriesProvider, child) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesProvider.categories.length,
                itemBuilder: (context, i) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0), // spacing
                  child: TextButton(
                      style: KCustomButtonStyle.categoryButtonStyle(),
                      onPressed: () {},
                      child: Text(
                        categoriesProvider.categories[i]["name"],
                        style: KCustomTextStyle.buttonTextStyle(),
                      )),
                ),
              );
            },
          ),
        ),
        KPopularSection.popularSection(),
        KLatestSection.latestSection(),
      ],
    );
  }
}
