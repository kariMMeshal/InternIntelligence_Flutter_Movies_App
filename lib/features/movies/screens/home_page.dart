import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_button_style.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_text_style.dart';
import 'package:flutter_movie_app_2/features/movies/models/movie_model.dart';
import 'package:flutter_movie_app_2/features/movies/providers/categories_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/latest_movies_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/popular_movies_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/toprated_movie_provider.dart';
import 'package:flutter_movie_app_2/features/movies/screens/movie_details_page.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/common/widgets/image_slider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie>? topRatedMovies;
  List pages = [const HomePage()];
  @override
  void initState() {
    super.initState();
    context.read<PopularMovieProvider>().fetchMovies();
    context.read<TopRatedMovieProvider>().fetchMovies();
    context.read<CategoriesProvider>().fetchMovies();
    context.read<LatestMoviesProvider>().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    topRatedMovies = context.watch<TopRatedMovieProvider>().topRatedMovies;
    return Scaffold(
      backgroundColor: KColors.primaryBackground,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_outline_rounded,
              ),
              label: "Saved"),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_rounded), label: "Downloads"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_sharp), label: "Profile"),
        ],
      ),
      body: ListView(
        children: [
          KImageSlider.slider(movies: topRatedMovies!),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              "Categories",
              style: KCustomTextStyle.sectionsTextStyle(),
            ),
          ),
          const SizedBox(height: 10),
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
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Most Popular",
                    style: KCustomTextStyle.sectionsTextStyle()),
                Text("show all", style: KCustomTextStyle.buttonTextStyle()),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: Consumer<PopularMovieProvider>(
              builder: (context, popularMovieProvider, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularMovieProvider.popularMovies.length,
                  itemBuilder: (context, index) {
                    final popularMovie =
                        popularMovieProvider.popularMovies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                              movieId: popularMovie.id.toString(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        width: 230,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original${popularMovie.posterPath}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Latest Movies",
                    style: KCustomTextStyle.sectionsTextStyle()),
                Text("show all", style: KCustomTextStyle.buttonTextStyle()),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: Consumer<LatestMoviesProvider>(
              builder: (context, latestMoviesProvider, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: latestMoviesProvider.latestMovies.length,
                  itemBuilder: (context, index) {
                    final latestMovie =
                        latestMoviesProvider.latestMovies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                              movieId: latestMovie.id.toString(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        width: 230,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original${latestMovie.posterPath}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
