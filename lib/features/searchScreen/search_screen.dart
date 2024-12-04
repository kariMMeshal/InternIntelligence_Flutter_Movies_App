import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/common/widgets/custom_textfield.dart';
import 'package:flutter_movie_app_2/features/searchScreen/models/recent_section.dart';
import 'package:flutter_movie_app_2/features/searchScreen/models/recommended_section.dart';
import 'package:flutter_movie_app_2/features/searchScreen/models/searched_section.dart';
import 'package:flutter_movie_app_2/features/searchScreen/providers/recommended_provider.dart';
import 'package:flutter_movie_app_2/features/searchScreen/providers/search_movies_provider.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/get_userid.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchText = TextEditingController();

  Future<void> fetchData() async {
    String? userId = await getUserId();

    if (userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context
            .read<SearchMoviesProvider>()
            .fetchMovies(searchText: searchText.text);
        context.read<RecommendedProvider>().fetchClickedMovies(userId);
        context.read<RecommendedProvider>().fetchMovieRecommendations();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  Future<void> handleRefresh() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchMoviesProvider>(
      builder: (context, provider, child) => RefreshIndicator(
        onRefresh: handleRefresh,
        child: ListView(
          children: [
            const SizedBox(height: 40),
            KCustomTextfield(
              icon: const Icon(Icons.search),
              hint: "search by title",
              myController: searchText,
              onSubmit: () {
                debugPrint(searchText.text);
                provider.fetchMovies(searchText: searchText.text);
              },
              suffixOntap: () {
                searchText.text = "";
                FocusScope.of(context).unfocus();
                provider.fetchMovies(searchText: searchText.text);
              },
              prefixOntap: () {
                debugPrint(searchText.text);
                FocusScope.of(context).unfocus();
                provider.fetchMovies(searchText: searchText.text);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            searchText.text.isNotEmpty
                ? searchedMoviesSection()
                : Column(
                    children: [recentSection(), recommendedSection()],
                  ),
          ],
        ),
      ),
    );
  }
}
