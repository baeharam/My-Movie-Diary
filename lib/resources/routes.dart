import 'package:flutter/material.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/main/drawer_screen.dart';
import 'package:mymovie/screens/main/screens.dart';

// Routes
final Map<String, WidgetBuilder> routes =  {
  routeIntro: (BuildContext context) => IntroScreen(),
  routeHome: (BuildContext context) => HomeScreen(),
  routeSearch: (BuildContext context) => SearchScreen(),
  routeDiaryList: (BuildContext context) => DiaryListScreen(),
  routeDrawer: (BuildContext context) => DrawerScreen()
};
