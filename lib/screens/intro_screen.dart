import 'package:flutter/material.dart';
import 'package:mymovie/bloc_helpers/bloc_event_state_builder.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:mymovie/utils/service_locator.dart';

class IntroScreen extends StatefulWidget{

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin{

  final IntroBloc introBloc = sl.get<IntroBloc>();
  AnimationController animationController;
  Animation buttonSqueeze;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this
    );
    buttonSqueeze = Tween(
      begin: 320.0,
      end: 70.0
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.0,0.250)
    ));
    animationController.addListener(() {
      if(animationController.isCompleted) {
        introBloc.emitEvent(IntroEventKakaoLogin());
      }
    });
  }

  Future<void> _playAnimation() async{
    try {
      await animationController.forward();
    } on TickerCanceled {}
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
            AnimatedBuilder(
              animation: buttonSqueeze,
              builder: (_,__){
                return BlocBuilder(
                  bloc: introBloc,
                  builder: (context, IntroState state){
                    if(state.isKakaoLoginSucceeded) {
                      BlocNavigator.pushReplacementNamed(context, routeHome);
                    }
                    if(state.isKakaoLoginFailed) {
                      BlocSnackbar.show(context, '로그인에 실패하였습니다.');
                      introBloc.emitEvent(IntroEventStateClear());
                    }
                    return GestureDetector(
                      child: Container(
                        width: buttonSqueeze.value,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: buttonSqueeze.value>75.0 ? Row(
                          children: <Widget>[
                            SizedBox(width: 20.0),
                            buttonSqueeze.value<100.0 ? Container() :
                            Image.asset('assets/images/kakao.png'),
                            buttonSqueeze.value<300.0 ? Container() :
                            Container(
                              child: Text(
                                '카카오톡으로 로그인',
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                                ),
                              ),
                            )
                          ],
                        ) : 
                        SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
                            strokeWidth: 1.0,
                          ),
                          width: 30.0,
                          height: 30.0,
                        )
                      ),
                      onTap: () => _playAnimation()
                    );
                  }
                );
              }
            )
          ],
        )
      )
    );
  }
}