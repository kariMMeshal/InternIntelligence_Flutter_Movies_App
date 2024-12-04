import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_app_2/app.dart';
import 'package:flutter_movie_app_2/features/DownloadsScreen/providers/downloaded_movies_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/categories_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/latest_movies_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/movie_detail_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/popular_movies_provider.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/providers/toprated_movie_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/similar_provider.dart';
import 'package:flutter_movie_app_2/features/MovieDetailsScreen/providers/trailer_provider.dart';
import 'package:flutter_movie_app_2/features/SavedScreen/providers/saved_provider.dart';
import 'package:flutter_movie_app_2/features/searchScreen/providers/search_movies_provider.dart';
import 'package:provider/provider.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PopularMovieProvider()),
        ChangeNotifierProvider(create: (_) => TopRatedMovieProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => LatestMoviesProvider()),
        ChangeNotifierProvider(create: (_) => MovieDetailsProvider()),
        ChangeNotifierProvider(create: (_) => TrailerProvider()),
        ChangeNotifierProvider(create: (_) => SimilarProvider()),
        ChangeNotifierProvider(create: (_) => SearchMoviesProvider()),
        ChangeNotifierProvider(create: (_) => SavedMoviesProvider()),
        ChangeNotifierProvider(create: (_) => DownloadedMoviesProvider()),
      ],
      child: const App(),
    ),
  );
}
