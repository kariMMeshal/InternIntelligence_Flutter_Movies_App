import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/helpers/sqfileHelper/add_movie_tosqflite.dart';
import 'package:flutter_movie_app_2/utils/helpers/sqfileHelper/read_movies_fromsqflite.dart';
import 'package:flutter_movie_app_2/utils/helpers/sqfileHelper/remove_movie_fromsqflite.dart';
import 'package:flutter_movie_app_2/utils/helpers/sqfileHelper/sqflite_db_helper.dart';
import 'package:sqflite/sqflite.dart';

class DownloadedMoviesProvider with ChangeNotifier {
  List<Movie> downloadedMovies = [];
  bool isLoading = false;
  final _readMoviesHelper = ReadMoviesFromsqflite();
  final _addMovieHelper = AddMovieTosqflite();
  final _removeMovieHelper = RemoveMovieFromsqflite();
  String? _userId;
  Database? database;

  set userId(String userId) {
    _userId = userId;
    fetchDownloadedMovies();
  }

  Future<void> openDatabaseConnection() async {
    database ??= await SqfliteDbHelper().initDatabase();
  }

  Future<void> fetchDownloadedMovies() async {
    if (_userId == null) return;
    await openDatabaseConnection();
    isLoading = true;
    notifyListeners();
    try {
      downloadedMovies = await _readMoviesHelper.fetchUserMovies(_userId!);
    } catch (e) {
      debugPrint("Error: $e");
      downloadedMovies = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMovieToSqfliet(Movie movie) async {
    if (_userId == null) return;
    await openDatabaseConnection();
    try {
      await _addMovieHelper.addMovie(_userId!, movie);
      downloadedMovies.add(movie);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> removeMovieFromSqfile(int movieId) async {
    if (_userId == null) return;
    await openDatabaseConnection();
    try {
      await _removeMovieHelper.removeMovie(movieId, _userId!);
      downloadedMovies.removeWhere((movie) => movie.id == movieId);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    database?.close();
    super.dispose();
  }
}
