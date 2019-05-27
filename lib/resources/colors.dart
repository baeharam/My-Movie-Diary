
// Search Screen
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static const Color searchStar = Color(0xFFFCBE11);
  static const Color facebookLogo = Color(0xFF3C5A99);

  static const Color darkBlueLight = Color(0xFF414B6F);
  static const Color darkBlueDark = Color(0xff2f3651);

  static const Color blueGreyLight = Color(0xff607D8B);
  static const Color blueGreyDark = Color(0xff4a6572);

  static const Color diaryResultText = Color(0xfff4f5f9);
  static const Color diaryResultComponent = Colors.black87;

  static const List<Color> diaryResultBackgroundColors = [Color(0xff0f0c29),Color(0xff302b63),Color(0xff24243e)];
  static const diaryResultGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: AppColor.diaryResultBackgroundColors,
      stops: [0.3,0.5,0.9],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
    )
  );

}