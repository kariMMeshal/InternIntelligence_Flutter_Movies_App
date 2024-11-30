import 'package:flutter/material.dart';
import 'package:flutter_movie_app_2/features/Auth/Screens/login_page.dart';
import 'package:flutter_movie_app_2/main_page.dart';
import 'package:flutter_movie_app_2/utils/helpers/authFunctions/check_state.dart';
import 'package:flutter_movie_app_2/utils/themes/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool? isVerified;

  Future<void> getVerificationState() async {
    isVerified = await CheckState.isUserSignedIn();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getVerificationState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,
      home: isVerified == null
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : (isVerified! ? const MainPage() : const LoginPage()),
    );
  }
}
