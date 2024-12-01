import 'dart:convert'; // For encoding genres list
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';
import 'package:flutter_movie_app_2/utils/helpers/sqfileHelper/sqflite_db_helper.dart';
import 'package:sqflite/sqflite.dart';

class AddMovieTosqflite {
  
  Future<int> addMovie(String userId, Movie movie) async {
    final db = await SqfliteDbHelper().database;
    return await db.insert(
      SqfliteDbHelper.tableName,
      {
        SqfliteDbHelper.columnMovieId: movie.id,
        SqfliteDbHelper.columnUserId: userId,
        SqfliteDbHelper.columnTitle: movie.title,
        SqfliteDbHelper.columnPosterPath: movie.posterPath,
        SqfliteDbHelper.columnDescription: movie.description,
        SqfliteDbHelper.columnReleaseDate: movie.releaseDate,
        SqfliteDbHelper.columnRating: movie.rating,
        SqfliteDbHelper.columnGenres:
            movie.genres != null ? jsonEncode(movie.genres) : null,
        SqfliteDbHelper.columnRuntime: movie.runtime,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
