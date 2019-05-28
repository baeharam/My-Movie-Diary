import 'package:flutter/material.dart';

class AnimationAPI {
  // Home
  AnimationController _homeFadeAnimationController;
  Animation _homeFadeAnimation;
  AnimationController get homeController => _homeFadeAnimationController;
  Animation get homeAnimation => _homeFadeAnimation;

  void initHome({@required TickerProvider vsync}) {
    _homeFadeAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1000)
    );
    _homeFadeAnimation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
      parent: _homeFadeAnimationController,
      curve: Curves.easeIn
    ));
    _homeFadeAnimationController.forward();
  }

  void disposeHome() => _homeFadeAnimationController.dispose();
  
}