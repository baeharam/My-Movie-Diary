import 'package:flutter/material.dart';
import 'package:mymovie/resources/constants.dart';

class AnimationAPI {
  // Intro
  AnimationController _introBackgroundController;
  Animation _introBackgroundAnimation;
  AnimationController get introBackgroundController => _introBackgroundController;
  Animation get introBackgroundAnimation => _introBackgroundAnimation;

  // Home
  AnimationController _homeFadeAnimationController;
  Animation _homeFadeAnimation;
  AnimationController get homeController => _homeFadeAnimationController;
  Animation get homeAnimation => _homeFadeAnimation;

  void initIntroBackground({@required TickerProvider vsync}) {
    _introBackgroundController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 30)
    );
    _introBackgroundAnimation = IntTween(
      begin: 0,
      end: introBackgroundImageList.length-1
    ).animate(CurvedAnimation(
      parent: _introBackgroundController,
      curve: Curves.linearToEaseOut
    ));
    _introBackgroundController.repeat();
  }
  void disposeIntroBackground() => _introBackgroundController.dispose();

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