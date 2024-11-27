import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/app.dart';
import 'package:flutter_movie_app_2/features/movies/providers/categories_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/latest_movies_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/movie_detail_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/popular_movies_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/toprated_movie_provider.dart';
import 'package:flutter_movie_app_2/features/movies/providers/trailer_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PopularMovieProvider()),
        ChangeNotifierProvider(create: (_) => TopRatedMovieProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => LatestMoviesProvider()),
        ChangeNotifierProvider(create: (_) => MovieDetailsProvider()),
        ChangeNotifierProvider(create: (_) => TrailerProvider()),
      ],
      child: const App(),
    ),
  );
}
