import 'package:flutter_movie_app_2/utils/helpers/sqfileHelper/sqflite_db_helper.dart';

class RemoveMovieFromsqflite {
  Future<int> removeMovie(int movieId, String userId) async {
    final db = await SqfliteDbHelper().database;
    return await db.delete(
      SqfliteDbHelper.tableName,
      where:
          '${SqfliteDbHelper.columnMovieId} = ? AND ${SqfliteDbHelper.columnUserId} = ?',
      whereArgs: [movieId, userId],
    );
  }
}
