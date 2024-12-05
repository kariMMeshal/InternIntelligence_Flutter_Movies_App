import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_button_style.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_slider.dart';
import 'package:flutter_movie_app_2/features/CategoryScreen/category_movies_screen.dart';
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
  Future<void> fetchData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<PopularMovieProvider>().fetchMovies();
      await context.read<TopRatedMovieProvider>().fetchMovies();
      await context.read<CategoriesProvider>().fetchMovies();
      await context.read<LatestMoviesProvider>().fetchMovies();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> handleRefresh() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: ListView(
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryMoviesScreen(
                                    genreId: categoriesProvider.categories[i]
                                        ["id"],
                                    genre: categoriesProvider.categories[i]
                                        ["name"]),
                              ));
                        },
                        child: Text(
                          categoriesProvider.categories[i]["name"],
                          style: KCustomTextStyle.buttonTextStyle(),
                        )),
                  ),
                );
              },
            ),
          ),
          popularSection(context),
          latestSection(context),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
