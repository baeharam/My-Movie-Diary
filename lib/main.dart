import 'package:flutter/material.dart';
import 'package:mymovie/resources/routes.dart';
import 'package:mymovie/screens/main/intro_screen.dart';
import 'package:mymovie/utils/service_locator.dart';

void main() {
  setup();
  runApp(MyMovieApp());
}

class MyMovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
      theme: ThemeData(
        fontFamily: 'hanna',
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}