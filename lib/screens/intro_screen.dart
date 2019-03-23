import 'package:flutter/material.dart';
import 'package:mymovie/bloc_helpers/bloc_event_state_builder.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:mymovie/utils/service_locator.dart';

class IntroScreen extends StatefulWidget{

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin{

  final IntroBloc introBloc = sl.get<IntroBloc>();
  AnimationController kakaoController,googleController;
  Animation kakaoAnimation,googleAnimation;

  @override
  void initState() {
    super.initState();
    _kakaoInitialization();
    _googleInitialization();
  }

  @override
  void dispose() {
    kakaoController.dispose();
    googleController.dispose();
    super.dispose();
  }

  void _kakaoInitialization() {
    kakaoController = AnimationController(
      duration: const Duration(milliseconds: loginButtonDuration),
      vsync: this
    );
    kakaoAnimation = Tween(
      begin: loginButtonBeginWidth,
      end: loginButtonEndWidth
    ).animate(CurvedAnimation(
      parent: kakaoController,
      curve: Interval(loginBeginInterval,loginEndInterval)
    ));
    kakaoController.addListener(() {
      if(kakaoController.isCompleted) {
        introBloc.emitEvent(IntroEventKakaoLogin());
      }
    });
  }

  void _googleInitialization() {
    googleController = AnimationController(
      duration: const Duration(milliseconds: loginButtonDuration),
      vsync: this
    );
    googleAnimation = Tween(
      begin: loginButtonBeginWidth,
      end: loginButtonEndWidth
    ).animate(CurvedAnimation(
      parent: googleController,
      curve: Interval(loginBeginInterval,loginEndInterval)
    ));
    googleController.addListener(() {
      if(googleController.isCompleted) {
        introBloc.emitEvent(IntroEventGoogleLogin());
      }
    });
  }

  Widget _buildLoginButton({
    @required Animation animation,
    @required AnimationController controller,
    @required Image image,
    @required Color buttonColor,
    @required Color textColor,
    @required String message
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_,__){
        return BlocBuilder(
          bloc: introBloc,
          builder: (context, IntroState state){
            if(state.isKakaoLoginSucceeded || state.isGoogleLoginSucceeded) {
              BlocNavigator.pushReplacementNamed(context, routeHome);
            }
            if(state.isKakaoLoginFailed || state.isGoogleLoginFailed) {
              BlocSnackbar.show(context, '로그인에 실패하였습니다.');
              introBloc.emitEvent(IntroEventStateClear());
            }
            return GestureDetector(
              child: Container(
                width: animation.value,
                height: 60.0,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: animation.value>75.0 ? Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    animation.value<100.0 ? Container() :
                    image,
                    animation.value<300.0 ? Container() :
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
                  child: CircularProgressIndicator(),
                  width: 30.0,
                  height: 30.0,
                )
              ),
              onTap: () => _playAnimation(controller: controller)
            );
          }
        );
      }
    );
  }

  Future<void> _playAnimation({@required AnimationController controller}) async{
    try {
      await controller.forward();
    } on TickerCanceled {
      print("애니메이션이 취소되었습니다.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ironman.jpg'),
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
                  fontFamily: 'Chosunilbo_myungjo',
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
            _buildLoginButton(
              animation: kakaoAnimation,
              controller: kakaoController,
              image: Image(
                image: AssetImage('assets/images/kakao.png'),
                width: 50.0,
                height: 50.0,
              ),
              buttonColor: Colors.yellow,
              textColor: Colors.brown,
              message: '카카오톡으로 로그인'
            ),
            SizedBox(height: 20.0),
            _buildLoginButton(
              animation: googleAnimation,
              controller: googleController,
              image: Image(
                image: AssetImage('assets/images/google.png'),
                width: 50.0,
                height: 30.0,
              ),
              buttonColor: Colors.white,
              textColor: Colors.black,
              message: '구글계정으로 로그인'
            )
          ],
        )
      )
    );
  }
}