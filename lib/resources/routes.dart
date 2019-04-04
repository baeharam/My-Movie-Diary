import 'package:flutter/material.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/main/screens.dart';

// Routes
final Map<String, WidgetBuilder> routes =  {
  routeIntro: (BuildContext context) => IntroScreen(),
  routeHome: (BuildContext context) => HomeScreen(),
  routeSearch: (BuildContext context) => SearchScreen(),
};
