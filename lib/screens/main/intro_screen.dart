
import 'package:flutter/material.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/sub/intro_login_button.dart';
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
      body: AnimatedBuilder(
        animation: _backgroundImageAnimation,
        builder: (context, widget){
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(introBackgroundImageList[_backgroundImageAnimation.value]),
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
                    loginAnimation: _facebookAnimation,
                    loginAnimationController: _facebookController,
                    otherAnimationController: _googleController,
                    image: Image(
                      image: AssetImage(facebookImage),
                      width: 50.0,
                      height: 50.0
                    ),
                    buttonColor: facebookLogoColor,
                    textColor: Colors.white,
                    loadingColor: Colors.white,
                    message: stringLoginFacebook,
                    introBloc: _introBloc,
                  ),
                  SizedBox(height: 20.0),
                  LoginButton(
                    loginAnimation: _googleAnimation,
                    loginAnimationController: _googleController,
                    otherAnimationController: _facebookController,
                    image: Image(
                      image: AssetImage(googleImage),
                      width: 50.0,
                      height: 30.0,
                    ),
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    loadingColor: Colors.black,
                    message: stringLoginGoogle,
                    introBloc: _introBloc,
                  )
                ],
              ),
            )
          );
        }
      )
    );
  }
}