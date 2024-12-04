import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_textfield.dart';
import 'package:flutter_movie_app_2/features/HomeScreen/models/popular_section.dart';
import 'package:flutter_movie_app_2/features/searchScreen/models/searched_section.dart';
import 'package:flutter_movie_app_2/features/searchScreen/providers/search_movies_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchText = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<SearchMoviesProvider>()
          .fetchMovies(searchText: searchText.text);
    });
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchMoviesProvider>(
      builder: (context, provider, child) => ListView(
        children: [
          const SizedBox(height: 40),
          KCustomTextfield(
            icon: const Icon(Icons.search),
            hint: "search by title",
            myController: searchText,
            onSubmit: () {
              print(searchText.text);
              provider.fetchMovies(searchText: searchText.text);
            },
            suffixOntap: () {
              searchText.text = "";
              FocusScope.of(context).unfocus();
              provider.fetchMovies(searchText: searchText.text);
            },
            prefixOntap: () {
              print(searchText.text);
              FocusScope.of(context).unfocus();
              provider.fetchMovies(searchText: searchText.text);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          searchText.text.isNotEmpty
              ? KSearchedSection.searchedMoviesSection()
              : KPopularSection.popularSection()
        ],
      ),
    );
  }
}
