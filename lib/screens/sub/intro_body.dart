import 'package:flutter/material.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/strings.dart';

import 'intro_login_button.dart';

class IntroBody extends StatelessWidget {

  final IntroBloc introBloc;

  const IntroBody({
    Key key, 
    @required this.introBloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: AppColor.darkBlueLight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/logo.png'),
              color: Colors.white,
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 20.0),
            Container(
              color: Colors.white,
              width: 200.0,
              height: 4.0,
            ),
            SizedBox(height: 100.0),
            LoginButton(
              image: Image(
                image: AssetImage(facebookImage),
                width: 50.0,
                height: 50.0
              ),
              buttonColor: AppColor.facebookLogo,
              textColor: Colors.white,
              loadingColor: Colors.white,
              message: stringLoginFacebook,
              callback: () => introBloc.dispatch(IntroEventFacebookLogin()),
            ),
            SizedBox(height: 20.0),
            LoginButton(
              image: Image(
                image: AssetImage(googleImage),
                width: 50.0,
                height: 30.0,
              ),
              buttonColor: Colors.white,
              textColor: Colors.black,
              loadingColor: Colors.black,
              message: stringLoginGoogle,
              callback: () => introBloc.dispatch(IntroEventGoogleLogin()),
            ),
            SizedBox(height: 20.0),
            LoginButton(
              image: Image(
                image: AssetImage(kakaoImage),
                width: 50.0,
                height: 40.0,
              ),
              buttonColor: AppColor.kakaoLogo,
              textColor: Colors.black,
              loadingColor: Colors.black,
              message: stringLoginKakao,
              callback: () => introBloc.dispatch(IntroEventKakaoLogin()),
            )
          ],
        ),
      )
    );
  }
}