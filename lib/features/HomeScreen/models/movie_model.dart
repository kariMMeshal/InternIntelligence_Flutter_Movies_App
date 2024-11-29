class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String description;
  final String releaseDate;
  final double rating;
  final List<String>? genres; // Optional genres
  final int? runtime; // Optional runtime

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.description,
    required this.releaseDate,
    required this.rating,
    this.genres,
    this.runtime,
  });

  // A method to convert JSON into a Movie object
  factory Movie.fromJson(Map<String, dynamic> json) {
    // Convert genres list from JSON
    List<String>? genresList;
    if (json['genres'] != null) {
      genresList = (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList();
    }

    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      description: json['overview'],
      releaseDate: json['release_date'],
      rating: (json['vote_average'] as num).toDouble(),
      genres: genresList, // Assigning genres list
      runtime: json['runtime'], // runtime is optional
    );
  }
}
