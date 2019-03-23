import 'package:mymovie/bloc_helpers/bloc_event_state.dart';
import 'package:mymovie/logics/intro/intro_event.dart';
import 'package:mymovie/logics/intro/intro_state.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';

class IntroBloc extends BlocEventStateBase<IntroEvent,IntroState> {

  static final _kakaoAPI = FlutterKakaoLogin();
  
  @override
  IntroState get initialState => IntroState.initial();

  @override
  Stream<IntroState> eventHandler(IntroEvent event, IntroState currentState) async*{

    if(event is IntroEventStateClear) {
      yield IntroState();
    }

    if(event is IntroEventKakaoLogin) {
      try {
        await _kakaoAPI.logIn();
        KakaoLoginResult result = await _kakaoAPI.getUserMe();
        print(result.account.userNickname);
        yield IntroState.kakaoLoginSucceeded();
      } catch(exception) {
        print("카카오 로그인 실패: ${exception.toString()}");
        yield IntroState.kakaoLoginFailed();
      }
    }
  }


}