import 'package:flutter/services.dart';

class OrientationFixer {
  static void fixPortrait()
    => SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

  static void fixLandscape()
    => SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
} 