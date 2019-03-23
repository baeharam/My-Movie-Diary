import 'package:flutter/material.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/screens.dart';

// Routes
final Map<String, WidgetBuilder> routes =  {
  routeIntro: (BuildContext context) => IntroScreen(),
  routeHome: (BuildContext context) => HomeScreen(),
  routeSearchIntro: (BuildContext context) => SearchIntroScreen()
};
