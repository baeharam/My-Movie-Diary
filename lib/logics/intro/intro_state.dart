import 'package:mymovie/bloc_helpers/bloc_event_state.dart';

class IntroState extends BlocState {
  final bool isInitial;

  final bool isKakaoLoginLoading;
  final bool isKakaoLoginSucceeded;
  final bool isKakaoLoginFailed;

  final bool isGoogleLoginLoading;
  final bool isGoogleLoginSucceeded;
  final bool isGoogleLoginFailed;

  IntroState({
    this.isInitial: false,

    this.isKakaoLoginLoading: false,
    this.isKakaoLoginSucceeded: false,
    this.isKakaoLoginFailed: false,

    this.isGoogleLoginLoading: false,
    this.isGoogleLoginSucceeded: false,
    this.isGoogleLoginFailed: false
  });

  factory IntroState.initial() => IntroState(isInitial: true);

  factory IntroState.kakaoLoginLoading() => IntroState(isKakaoLoginLoading: true);
  factory IntroState.kakaoLoginSucceeded() => IntroState(isKakaoLoginSucceeded: true);
  factory IntroState.kakaoLoginFailed() => IntroState(isKakaoLoginFailed: true);

  factory IntroState.googleLoginLoading() => IntroState(isGoogleLoginLoading: true);
  factory IntroState.googleLoginSucceeded() => IntroState(isGoogleLoginSucceeded: true);
  factory IntroState.googleLoginFailed() => IntroState(isGoogleLoginFailed: true);
}