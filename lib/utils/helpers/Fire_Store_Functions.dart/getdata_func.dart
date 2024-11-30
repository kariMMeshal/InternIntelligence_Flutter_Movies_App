import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_movie_app_2/utils/helpers/movie_model.dart';

Future<List<Movie>> getMoviesFromFirestore() async {
  User? user = FirebaseAuth.instance.currentUser;
  List<Movie> moviesList = [];

  if (user != null) {
    try {
      // Get a reference to the user's document in Firestore
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Get a reference to the movies subcollection within the user's document
      CollectionReference moviesRef = userDocRef.collection('movies');

      // Query the movies collection for all documents
      QuerySnapshot snapshot = await moviesRef.get();

      // Loop through the query results and convert them to Movie objects
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Create a Movie object from the data
        Movie movie = Movie(
          id: data['id'],
          title: data['title'],
          posterPath: data['posterPath'],
          description: data['description'],
          releaseDate: data['releaseDate'],
          rating: data['rating'],
          genres:
              List<String>.from(data['genres'] ?? []), // Safely parse genres
          runtime: data['runtime'],
        );

        // Add the movie to the list
        moviesList.add(movie);
      }

      print("Movies fetched from Firestore!");
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  return moviesList;
}
