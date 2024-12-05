import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/widgets/movie_card.dart';
import 'package:flutter_movie_app_2/features/SavedScreen/providers/saved_provider.dart';

import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SavedMoviesProvider>().fetchSaved();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<SavedMoviesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                provider.savedMovies.isEmpty
                    ? "No Saved Movies"
                    : "Saved Movies",
                style: KCustomTextStyle.titleTextStyle(),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.savedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = provider.savedMovies[index];
                    return KMovieCard(
                      movie: movie,
                      onDeleteTap: () {
                        provider.removeMovie(movie.id.toString()).then((_) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Movie Removed From Saved :) '),
                          ));
                        });
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
