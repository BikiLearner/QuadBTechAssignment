import 'package:flutter/material.dart';
import 'package:quadb_tech/pages/home_screen.dart';
import 'package:quadb_tech/pages/search_screen.dart';
import 'package:quadb_tech/pages/splash_screen.dart';

void main() => runApp(MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
      },
    );
  }
}