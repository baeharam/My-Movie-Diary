import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'intro.dart';

class IntroBloc extends Bloc<IntroEvent,IntroState> {

  static final _api = IntroAPI();
  
  @override
  IntroState get initialState => IntroState.initial();

  @override
  Stream<IntroState> mapEventToState(IntroEvent event) async*{
    if(event is IntroEventStateClear) {
      yield IntroState.initial();
    }

    if(event is IntroEventFacebookLogin) {
      try {
        await _api.facebookAuthentication();
        yield IntroState.facebookLoginSucceeded();
      } catch(exception) {
        debugPrint("페이스북 로그인 실패: ${exception.toString()}");
        yield IntroState.facebookLoginFailed();
      }
    }

    if(event is IntroEventGoogleLogin) {
      try {
        await _api.googleAuthentication();
        yield IntroState.googleLoginSucceeded();
      } catch(exception) {
        debugPrint("구글 로그인 실패: ${exception.toString()}");
        yield IntroState.googleLoginFailed();
      }
    }
  }
}