import 'package:bloc/bloc.dart';

import 'intro.dart';

class IntroBloc extends Bloc<IntroEvent,IntroState> {

  static final _api = IntroAPI();
  
  @override
  IntroState get initialState => IntroState.initial();

  @override
  Stream<IntroState> mapEventToState(IntroEvent event) async*{
    if(event is IntroEventStateClear) {
      yield IntroState();
    }

    if(event is IntroEventKakaoLogin) {
      try {
        await _api.kakaoAuthentication();
        yield IntroState.kakaoLoginSucceeded();
      } catch(exception) {
        print("카카오 로그인 실패: ${exception.toString()}");
        yield IntroState.kakaoLoginFailed();
      }
    }

    if(event is IntroEventGoogleLogin) {
      try {
        await _api.googleAuthentication();
        yield IntroState.googleLoginSucceeded();
      } catch(exception) {
        print("구글 로그인 실패: ${exception.toString()}");
        yield IntroState.googleLoginFailed();
      }
    }
  }
}