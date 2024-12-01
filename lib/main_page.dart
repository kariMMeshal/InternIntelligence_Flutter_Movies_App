import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_navbar.dart';
import 'package:flutter_movie_app_2/features/DownloadsScreen/downloaded_movies_screen.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/home_page.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/categories_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/latest_movies_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/popular_movies_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/toprated_movie_provider.dart';
import 'package:flutter_movie_app_2/features/SavedScreen/saved_screen.dart';
import 'package:flutter_movie_app_2/features/searchScreen/search_screen.dart';
import 'package:flutter_movie_app_2/features/ProfileScreen/profile_screen.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Movie>? topRatedMovies;
  List<Widget> pages = [
    const HomePage(),
    const SearchScreen(),
    const SavedScreen(),
    const DownloadedScreen(),
    const ProfileScreen(),
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

  void onNavBarTapped(int index) {
    setState(() {
      activeIndex = index;
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
      bottomNavigationBar: KCustomBottomNavBar(
        currentIndex: activeIndex,
        onTap: (val) {
          onNavBarTapped(val);
        },
      ),
      body: pages[activeIndex],
    );
  }
}
