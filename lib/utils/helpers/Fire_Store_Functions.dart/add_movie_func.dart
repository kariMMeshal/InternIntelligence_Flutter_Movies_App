import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_movie_app_2/utils/helpers/Fire_Store_Functions.dart/check_is_saved.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart'; // Assuming Movie is imported here

Future<void> saveMovieToFirestore(Movie movie) async {
  User? user = FirebaseAuth.instance.currentUser;
  bool isSaved = false;
  print("saving....>.....>");

  if (user != null) {
    try {
      // Check if the movie is already saved using movieId
      isSaved = await checkIfMovieIsSaved(movie.id.toString());
      print(isSaved);
      if (isSaved) {
        print("Movie is already saved!");
        return;
      }

      DocumentReference movieRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('movies')
          .doc(movie.id.toString());

      // Convert Movie object to Map<String, dynamic>
      Map<String, dynamic> movieData = {
        'id': movie.id,
        'title': movie.title,
        'posterPath': movie.posterPath,
        'description': movie.description,
        'releaseDate': movie.releaseDate,
        'rating': movie.rating,
        'genres': movie.genres,
        'runtime': movie.runtime,
      };

      await movieRef.set(movieData);

      print("Movie saved to Firestore!");
    } catch (e) {
      print("Error saving movie: $e");
    }
  }
}
