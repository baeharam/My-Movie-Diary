
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
  }

  @override
  void dispose() {
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
          return Stack(
            children: <Widget>[
              if(state.isGoogleLoginLoading || state.isFacebookLoginLoading) 
                Container(
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              IntroBody(
                backgroundImageAnimation: sl.get<AnimationAPI>().introBackgroundAnimation,
                introBloc: _introBloc,
              ),
            ],
          );
        }
      )
    );
  }
}