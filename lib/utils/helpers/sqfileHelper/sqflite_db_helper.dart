import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDbHelper {
  static final SqfliteDbHelper _instance = SqfliteDbHelper._internal();
  factory SqfliteDbHelper() => _instance;
  SqfliteDbHelper._internal();

  static Database? _database;

  static const String tableName = 'movies';
  static const String columnMovieId = 'movieId';
  static const String columnUserId = 'userId';
  static const String columnTitle = 'title';
  static const String columnPosterPath = 'posterPath';
  static const String columnDescription = 'description';
  static const String columnReleaseDate = 'releaseDate';
  static const String columnRating = 'rating';
  static const String columnGenres = 'genres'; // JSON string
  static const String columnRuntime = 'runtime';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'movies_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $columnMovieId INTEGER PRIMARY KEY,
            $columnUserId TEXT NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnPosterPath TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnReleaseDate TEXT NOT NULL,
            $columnRating REAL NOT NULL,
            $columnGenres TEXT,
            $columnRuntime INTEGER
          )
        ''');
      },
    );
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}
