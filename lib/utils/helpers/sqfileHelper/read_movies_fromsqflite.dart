import 'dart:convert';

import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/helpers/sqfileHelper/sqflite_db_helper.dart'; // For decoding genres list

class ReadMoviesFromsqflite {
  Future<List<Movie>> fetchUserMovies(String userId) async {
    final db = await SqfliteDbHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      SqfliteDbHelper.tableName,
      where: '${SqfliteDbHelper.columnUserId} = ?',
      whereArgs: [userId],
    );

    List<Movie> downloadedMovies = List.generate(maps.length, (i) {
      return Movie(
        id: maps[i][SqfliteDbHelper.columnMovieId],
        title: maps[i][SqfliteDbHelper.columnTitle],
        posterPath: maps[i][SqfliteDbHelper.columnPosterPath],
        description: maps[i][SqfliteDbHelper.columnDescription],
        releaseDate: maps[i][SqfliteDbHelper.columnReleaseDate],
        rating: maps[i][SqfliteDbHelper.columnRating],
        genres: maps[i][SqfliteDbHelper.columnGenres] != null
            ? List<String>.from(
                jsonDecode(maps[i][SqfliteDbHelper.columnGenres]))
            : null,
        runtime: maps[i][SqfliteDbHelper.columnRuntime],
      );
    });

    return downloadedMovies;
  }
}
