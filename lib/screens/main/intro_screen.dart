
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/sub/intro_body.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:mymovie/utils/orientation_fixer.dart';
import 'package:mymovie/utils/service_locator.dart';

class IntroScreen extends StatefulWidget{

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin{

  final IntroBloc _introBloc = sl.get<IntroBloc>();
  AnimationController _facebookController,_googleController;
  AnimationController _backgroundImageController;
  Animation _facebookAnimation,_googleAnimation;
  Animation _backgroundImageAnimation;

  @override
  void initState() {
    super.initState();
    _introBloc.dispatch(IntroEventStateClear());
    _facebookInitialization();
    _googleInitialization();
    _backgroundInitialization();
  }

  @override
  void dispose() {
    _facebookController.dispose();
    _googleController.dispose();
    _backgroundImageController.dispose();
    _introBloc.dispose();
    super.dispose();
  }

  void _facebookInitialization() {
    _facebookController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this
    );
    _facebookAnimation = Tween(
      begin: 300.0,
      end: 70.0
    ).animate(CurvedAnimation(
      parent: _facebookController,
      curve: Interval(0.0,0.250)
    ));
    _facebookController.addListener(() {
      if(_facebookController.isCompleted) {
        _introBloc.dispatch(IntroEventFacebookLogin());
      }
    });
  }

  void _googleInitialization() {
    _googleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this
    );
    _googleAnimation = Tween(
      begin: 300.0,
      end: 70.0
    ).animate(CurvedAnimation(
      parent: _googleController,
      curve: Interval(0.0,0.250)
    ));
    _googleController.addListener(() {
      if(_googleController.isCompleted) {
        _introBloc.dispatch(IntroEventGoogleLogin());
      }
    });
  }

  void _backgroundInitialization() {
    _backgroundImageController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30)
    );
    _backgroundImageAnimation = IntTween(
      begin: 0,
      end: introBackgroundImageList.length-1
    ).animate(CurvedAnimation(
      parent: _backgroundImageController,
      curve: Curves.linearToEaseOut
    ));
    _backgroundImageController.repeat();
  }


  @override
  Widget build(BuildContext context) {
    OrientationFixer.fixPortrait();

    return Scaffold(
      body: BlocBuilder<IntroEvent,IntroState>(
        bloc: _introBloc,
        builder: (context, state){
          if(state.isFacebookLoginSucceeded || state.isGoogleLoginSucceeded) {
            BlocNavigator.pushReplacementNamed(context, routeHome);
          }
          if(state.isFacebookLoginFailed || state.isGoogleLoginFailed) {
            BlocSnackbar.show(context, '로그인에 실패하였습니다.');
          }
          return IntroBody(
            backgroundImageAnimation: _backgroundImageAnimation,
            facebookAnimation: _facebookAnimation,
            googleAnimation: _googleAnimation,
            facebookController: _facebookController,
            googleController: _googleController,
            introBloc: _introBloc,
          );
        }
      )
    );
  }
}