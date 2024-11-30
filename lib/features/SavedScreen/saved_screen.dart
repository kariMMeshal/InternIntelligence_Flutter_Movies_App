import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/styles/custom_button_style.dart';
import 'package:flutter_movie_app_2/common/styles/custom_text_style.dart';
import 'package:flutter_movie_app_2/common/styles/long_text_button.dart';
import 'package:flutter_movie_app_2/common/widgets/image_card.dart';
import 'package:flutter_movie_app_2/features/SavedScreen/providers/saved_provider.dart';
import 'package:flutter_movie_app_2/utils/constants/colors.dart';
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
    context.read<SavedMoviesProvider>().fetchSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedMoviesProvider>(
      builder: (context, provider, child) {
        print(provider.savedMovies);
        return Column(
          children: [
            const SizedBox(height: 50),
            Text("Saved", style: KCustomTextStyle.titleTextStyle()),
            Expanded(
              child: ListView.builder(
                itemCount: provider.savedMovies.length,
                itemBuilder: (context, index) {
                  final movie = provider.savedMovies[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: KColors.secondary,
                        borderRadius: BorderRadius.circular(25)),
                    height: 250,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 170,
                          height: 250,
                          child: KImageCard.imageCard(
                            imagePath:
                                "https://image.tmdb.org/t/p/original${movie.posterPath}",
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: KCustomTextStyle.buttonTextStyle(),
                                    softWrap: true,
                                  ),
                                  Text(movie.genres!.take(2).join(", "),
                                      style:
                                          KCustomTextStyle.subTitleTextStyle()),
                                ],
                              ),
                              const SizedBox(height: 100),
                              KLongTextButton.longtextButton(
                                  title: "Watch Now ",
                                  iconData: Icons.play_arrow,
                                  backGroundColor: KColors.buttonPrimary)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
