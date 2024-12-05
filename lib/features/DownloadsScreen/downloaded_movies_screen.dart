import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/movie_card.dart';
import 'package:flutter_movie_app_2/features/DownloadsScreen/providers/downloaded_movies_provider.dart';

import 'package:provider/provider.dart';

class DownloadedScreen extends StatefulWidget {
  const DownloadedScreen({super.key});

  @override
  State<DownloadedScreen> createState() => _DownloadedScreenState();
}

class _DownloadedScreenState extends State<DownloadedScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch downloaded movies based on the current user's ID
    context.read<DownloadedMoviesProvider>().userId =
        FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadedMoviesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                provider.downloadedMovies.isEmpty
                    ? "No Downloaded Movies"
                    : "Downloads",
                style: KCustomTextStyle.titleTextStyle(),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.downloadedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = provider.downloadedMovies[index];
                    return KMovieCard(
                      movie: movie,
                      onDeleteTap: () {
                        provider.removeMovieFromSqfile(movie.id).then((_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Movie Removed From Downloads :) '),
                            ));
                          }) ;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
