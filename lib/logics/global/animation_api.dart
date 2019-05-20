import 'package:flutter/material.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/service_locator.dart';

class AnimationAPI {
  // Intro
  AnimationController _introFacebookController,_introGoogleController;
  AnimationController _introBackgroundController;
  Animation _introFacebookAnimation,_introGoogleAnimation;
  Animation _introBackgroundAnimation;
  AnimationController get introFacebookController => _introFacebookController;
  Animation get introFacebookAnimation => _introFacebookAnimation;
  AnimationController get introGoogleController => _introGoogleController;
  Animation get introGoogleAnimation => _introGoogleAnimation;
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

  void initIntroGoogle({@required TickerProvider vsync}) {
    _introGoogleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: vsync
    );
    _introGoogleAnimation = Tween(
      begin: 300.0,
      end: 70.0
    ).animate(CurvedAnimation(
      parent: _introGoogleController,
      curve: Interval(0.0,0.250)
    ));
    _introGoogleController.addListener(() {
      if(_introGoogleController.isCompleted) {
        sl.get<IntroBloc>().dispatch(IntroEventGoogleLogin());
      }
    });
  }
  void disposeIntroGoogle() => _introGoogleController.dispose();

  void initIntroFacebook({@required TickerProvider vsync}) {
    _introFacebookController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: vsync
    );
    _introFacebookAnimation = Tween(
      begin: 300.0,
      end: 70.0
    ).animate(CurvedAnimation(
      parent: _introFacebookController,
      curve: Interval(0.0,0.250)
    ));
    _introFacebookController.addListener(() {
      if(_introFacebookController.isCompleted) {
        sl.get<IntroBloc>().dispatch(IntroEventFacebookLogin());
      }
    });
  }
  void disposeIntroFacebook() => _introFacebookController.dispose();

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