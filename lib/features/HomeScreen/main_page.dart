import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/animations/fade_transition.dart';
import 'package:flutter_movie_app_2/common/styles/custom_button_style.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/home_page.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/models/movie_model.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/categories_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/latest_movies_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/popular_movies_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/toprated_movie_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/movie_details_page.dart';
import 'package:flutter_movie_app_2/features/searchScreen/search_screen.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:flutter_movie_app_2/common/widgets/image_slider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  List<Movie>? topRatedMovies;
  List pages = [
    const HomePage(),
    const SearchScreen(),
  ];
  int activeIndex = 0;

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
    topRatedMovies = context.watch<TopRatedMovieProvider>().topRatedMovies;
    return Scaffold(
      backgroundColor: KColors.primaryBackground,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          activeIndex = value;
          setState(() {});
        },
        currentIndex: activeIndex,
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
      body: pages[activeIndex],
    );
  }

  ListView homePage() {
    return ListView(
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
              Text("Most Popular", style: KCustomTextStyle.sectionsTextStyle()),
              Text("show all", style: KCustomTextStyle.buttonTextStyle()),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: Consumer<PopularMovieProvider>(
            builder: (context, provider, child) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.popularMovies.length,
                  itemBuilder: (context, index) {
                    final movie = provider.popularMovies[index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              fadeTransition(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        MovieDetailsPage(
                                            movieId: movie.id.toString())),
                              ));
                        },
                        child: Hero(
                            tag: "popular_poster${movie.id}",
                            child: KImageCard.imageCard(
                                imagePath:
                                    "https://image.tmdb.org/t/p/original${movie.posterPath}")));
                  });
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
                  final latestMovie = latestMoviesProvider.latestMovies[index];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            fadeTransition(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        MovieDetailsPage(
                                          movieId: latestMovie.id.toString(),
                                        ))));
                      },
                      child: Hero(
                          tag: "latest_poster${latestMovie.id}",
                          child: KImageCard.imageCard(
                              imagePath:
                                  "https://image.tmdb.org/t/p/original${latestMovie.posterPath}")));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
