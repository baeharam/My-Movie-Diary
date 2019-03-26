
import 'package:flutter/material.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/widgets/intro_login_button.dart';

class IntroScreen extends StatefulWidget{

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin{

  final IntroBloc _introBloc = sl.get<IntroBloc>();
  AnimationController _kakaoController,_googleController;
  AnimationController _backgroundImageController;
  Animation _kakaoAnimation,_googleAnimation;
  Animation _backgroundImageAnimation;

  @override
  void initState() {
    super.initState();
    _kakaoInitialization();
    _googleInitialization();
    _backgroundInitialization();
  }

  @override
  void dispose() {
    _kakaoController.dispose();
    _googleController.dispose();
    _backgroundImageController.dispose();
    super.dispose();
  }

  void _kakaoInitialization() {
    _kakaoController = AnimationController(
      duration: const Duration(milliseconds: loginButtonDuration),
      vsync: this
    );
    _kakaoAnimation = Tween(
      begin: loginButtonBeginWidth,
      end: loginButtonEndWidth
    ).animate(CurvedAnimation(
      parent: _kakaoController,
      curve: Interval(loginBeginInterval,loginEndInterval)
    ));
    _kakaoController.addListener(() {
      if(_kakaoController.isCompleted) {
        _introBloc.emitEvent(IntroEventKakaoLogin());
      }
    });
  }

  void _googleInitialization() {
    _googleController = AnimationController(
      duration: const Duration(milliseconds: loginButtonDuration),
      vsync: this
    );
    _googleAnimation = Tween(
      begin: loginButtonBeginWidth,
      end: loginButtonEndWidth
    ).animate(CurvedAnimation(
      parent: _googleController,
      curve: Interval(loginBeginInterval,loginEndInterval)
    ));
    _googleController.addListener(() {
      if(_googleController.isCompleted) {
        _introBloc.emitEvent(IntroEventGoogleLogin());
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
      end: backgroundImageList.length-1
    ).animate(CurvedAnimation(
      parent: _backgroundImageController,
      curve: Curves.linearToEaseOut
    ));
    _backgroundImageController.repeat();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundImageAnimation,
        builder: (context, widget){
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImageList[_backgroundImageAnimation.value]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Text(
                      '영화일기',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
                    loginAnimation: _kakaoAnimation,
                    loginAnimationController: _kakaoController,
                    image: Image(
                      image: AssetImage('assets/images/kakao.png'),
                      width: 50.0,
                      height: 50.0,
                    ),
                    buttonColor: Colors.yellow,
                    textColor: Colors.brown,
                    message: '카카오톡으로 로그인',
                    introBloc: _introBloc,
                  ),
                  SizedBox(height: 20.0),
                  LoginButton(
                    loginAnimation: _googleAnimation,
                    loginAnimationController: _googleController,
                    image: Image(
                      image: AssetImage('assets/images/google.png'),
                      width: 50.0,
                      height: 30.0,
                    ),
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    message: '구글계정으로 로그인',
                    introBloc: _introBloc,
                  )
                ],
              )
            ),
          );
        }
      )
    );
  }
}