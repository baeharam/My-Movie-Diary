
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/global/animation_api.dart';
import 'package:mymovie/logics/intro/intro.dart';
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

  @override
  void initState() {
    super.initState();
    _introBloc.dispatch(IntroEventStateClear());
    sl.get<AnimationAPI>().initIntroBackground(vsync: this);
    sl.get<AnimationAPI>().initIntroFacebook(vsync: this);
    sl.get<AnimationAPI>().initIntroGoogle(vsync: this);
  }

  @override
  void dispose() {
    sl.get<AnimationAPI>().disposeIntroBackground();
    sl.get<AnimationAPI>().disposeIntroFacebook();
    sl.get<AnimationAPI>().disposeIntroGoogle();
    _introBloc.dispatch(IntroEventStateClear());
    super.dispose();
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
            backgroundImageAnimation: sl.get<AnimationAPI>().introBackgroundAnimation,
            facebookAnimation: sl.get<AnimationAPI>().introFacebookAnimation,
            googleAnimation: sl.get<AnimationAPI>().introGoogleAnimation,
            facebookController: sl.get<AnimationAPI>().introFacebookController,
            googleController: sl.get<AnimationAPI>().introGoogleController,
            introBloc: _introBloc,
          );
        }
      )
    );
  }
}