import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/sub/intro_body.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:mymovie/utils/orientation_fixer.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/widgets/modal_progress.dart';

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
          if(state.isFacebookLoginSucceeded || state.isGoogleLoginSucceeded || state.isKakaoLoginSucceeded){
            BlocNavigator.pushReplacementNamed(context, routeDrawer);
          }
          if(state.isFacebookLoginFailed || state.isGoogleLoginFailed || state.isKakaoLoginFailed) {
            BlocSnackbar.show(context, '로그인에 실패하였습니다.');
          }
          return Stack(
            children: <Widget>[
              IntroBody(introBloc: _introBloc),
              if(state.isGoogleLoginLoading || state.isFacebookLoginLoading || state.isKakaoLoginLoading ||
              state.isFacebookLoginSucceeded || state.isGoogleLoginSucceeded || state.isKakaoLoginSucceeded)
                ModalProgress(text: '로그인 중입니다...',)
            ],
          );
        }
      )
    );
  }
}