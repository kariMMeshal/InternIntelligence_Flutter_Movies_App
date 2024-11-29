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

  void fetchData() {
    context.read<SearchMoviesProvider>().fetchMovies(
          searchText: searchText.text,
        );
  }

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 70),
        KCustomTextfield(
          icon: const Icon(Icons.search),
          hint: "search by title",
          myController: searchText,
          onSubmit: () {
            fetchData();
          },
          suffixOntap: () {
            searchText.text = "";
            FocusScope.of(context).unfocus();
            fetchData();
          },
          prefixOntap: () {
            FocusScope.of(context).unfocus();
            fetchData();
          },
        ),
        const SizedBox(
          height: 50,
        ),
        searchText.text.isNotEmpty
            ? KSearchedSection.searchedMoviesSection()
            : KPopularSection.popularSection()
      ],
    );
  }
}
