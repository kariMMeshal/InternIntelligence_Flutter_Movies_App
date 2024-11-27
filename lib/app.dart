import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/movies/screens/home_page.dart';
import 'package:flutter_movie_app_2/utils/themes/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      themeMode: ThemeMode.system,
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,
    );
  }
}
