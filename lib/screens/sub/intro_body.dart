import 'package:flutter/material.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/strings.dart';

import 'intro_login_button.dart';

class IntroBody extends StatelessWidget {

  final Animation backgroundImageAnimation;
  final Animation facebookAnimation;
  final Animation googleAnimation;

  final AnimationController facebookController;
  final AnimationController googleController;
  final IntroBloc introBloc;

  const IntroBody({
    Key key, 
    @required this.backgroundImageAnimation, 
    @required this.facebookAnimation, 
    @required this.googleAnimation, 
    @required this.facebookController, 
    @required this.googleController, 
    @required this.introBloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: backgroundImageAnimation,
      builder: (context, widget){
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(introBackgroundImageList[backgroundImageAnimation.value]),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 180.0),
                  child: Text(
                    '영화일기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  color: Colors.white,
                  width: 200.0,
                  height: 4.0,
                ),
                SizedBox(height: 200.0),
                LoginButton(
                  loginAnimation: facebookAnimation,
                  loginAnimationController: facebookController,
                  otherAnimationController: googleController,
                  image: Image(
                    image: AssetImage(facebookImage),
                    width: 50.0,
                    height: 50.0
                  ),
                  buttonColor: facebookLogoColor,
                  textColor: Colors.white,
                  loadingColor: Colors.white,
                  message: stringLoginFacebook,
                  introBloc: introBloc,
                ),
                SizedBox(height: 20.0),
                LoginButton(
                  loginAnimation: googleAnimation,
                  loginAnimationController: googleController,
                  otherAnimationController: facebookController,
                  image: Image(
                    image: AssetImage(googleImage),
                    width: 50.0,
                    height: 30.0,
                  ),
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  loadingColor: Colors.black,
                  message: stringLoginGoogle,
                  introBloc: introBloc,
                )
              ],
            ),
          )
        );
      }
    );
  }
}