import 'package:flutter/material.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/logics/intro/intro_bloc.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {

  final AnimationController loginAnimationController;
  final AnimationController otherAnimationController;
  final Animation loginAnimation;
  final Image image;
  final Color buttonColor;
  final Color textColor;
  final Color loadingColor;
  final String message;
  final IntroBloc introBloc;


  LoginButton({
    Key key,
    @required this.loginAnimationController,
    @required this.otherAnimationController,
    @required this.loginAnimation,
    @required this.image,
    @required this.buttonColor,
    @required this.textColor,
    @required this.loadingColor,
    @required this.message,
    @required this.introBloc
  }) : super(key: key);

  Future<void> _playAnimation({@required AnimationController controller}) async{
    try {
      await controller.forward();
    } on TickerCanceled {
      print("애니메이션이 취소되었습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroEvent,IntroState>(
      bloc: introBloc,
      builder: (context, IntroState state){
        if(state.isFacebookLoginSucceeded || state.isGoogleLoginSucceeded) {
          BlocNavigator.pushReplacementNamed(context, routeHome);
        }
        if(state.isFacebookLoginFailed || state.isGoogleLoginFailed) {
          BlocSnackbar.show(context, '로그인에 실패하였습니다.');
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
                    valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
                  ),
                  width: 30.0,
                  height: 30.0,
                )
              );
            }
          ),
          onTap: () => otherAnimationController.isAnimating ? null
            : _playAnimation(controller: loginAnimationController)
        );
      }
    );
  }
}