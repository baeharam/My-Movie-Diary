import 'package:mymovie/bloc_helpers/bloc_event_state.dart';
import 'package:mymovie/logics/intro/intro.dart';

class IntroBloc extends BlocEventStateBase<IntroEvent,IntroState> {

  static final _api = IntroAPI();
  
  @override
  IntroState get initialState => IntroState.initial();

  @override
  Stream<IntroState> eventHandler(IntroEvent event, IntroState currentState) async*{

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