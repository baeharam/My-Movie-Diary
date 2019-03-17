import 'package:mymovie/bloc_helpers/bloc_event_state.dart';

class IntroState extends BlocState {
  final bool isInitial;

  final bool isKakaoLoginLoading;
  final bool isKakaoLoginSucceeded;
  final bool isKakaoLoginFailed;

  IntroState({
    this.isInitial: false,
    this.isKakaoLoginLoading: false,
    this.isKakaoLoginSucceeded: false,
    this.isKakaoLoginFailed: false
  });

  factory IntroState.initial() => IntroState(isInitial: true);

  factory IntroState.kakaoLoginLoading() => IntroState(isKakaoLoginLoading: true);
  factory IntroState.kakaoLoginSucceeded() => IntroState(isKakaoLoginSucceeded: true);
  factory IntroState.kakaoLoginFailed() => IntroState(isKakaoLoginFailed: true);
}