import 'package:flutter/material.dart';
import 'package:mymovie/bloc_helpers/bloc_event_state_builder.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/logics/intro/intro_bloc.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';

class LoginButton extends StatelessWidget {

  final AnimationController loginAnimationController;
  final Animation loginAnimation;
  final Image image;
  final Color buttonColor;
  final Color textColor;
  final String message;
  final IntroBloc introBloc;


  LoginButton({
    @required this.loginAnimationController,
    @required this.loginAnimation,
    @required this.image,
    @required this.buttonColor,
    @required this.textColor,
    @required this.message,
    @required this.introBloc
  });

  Future<void> _playAnimation({@required AnimationController controller}) async{
    try {
      await controller.forward();
    } on TickerCanceled {
      print("애니메이션이 취소되었습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: introBloc,
      builder: (context, IntroState state){
        if(state.isKakaoLoginSucceeded || state.isGoogleLoginSucceeded) {
          BlocNavigator.pushReplacementNamed(context, routeHome);
          introBloc.emitEvent(IntroEventStateClear());
        }
        if(state.isKakaoLoginFailed || state.isGoogleLoginFailed) {
          BlocSnackbar.show(context, '로그인에 실패하였습니다.');
          introBloc.emitEvent(IntroEventStateClear());
        }
        return GestureDetector(
          child: AnimatedBuilder(
            animation: loginAnimation,
            builder: (_,__){
              return Container(
                width: loginAnimation.value,
                height: 60.0,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: loginAnimation.value>75.0 ? Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    loginAnimation.value<100.0 ? Container() :
                    image,
                    loginAnimation.value<300.0 ? Container() :
                    Container(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),
                      ),
                    )
                  ],
                ) : 
                Container(
                  margin: const EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                  width: 30.0,
                  height: 30.0,
                )
              );
            }
          ),
          onTap: () => _playAnimation(controller: loginAnimationController)
        );
      }
    );
  }
}