class IntroState {
  final bool isInitial;

  final bool isFacebookLoginLoading;
  final bool isFacebookLoginSucceeded;
  final bool isFacebookLoginFailed;

  final bool isGoogleLoginLoading;
  final bool isGoogleLoginSucceeded;
  final bool isGoogleLoginFailed;

  final bool isKakaoLoginLoading;
  final bool isKakaoLoginSucceeded;
  final bool isKakaoLoginFailed;

  IntroState({
    this.isInitial: false,

    this.isFacebookLoginLoading: false,
    this.isFacebookLoginSucceeded: false,
    this.isFacebookLoginFailed: false,

    this.isGoogleLoginLoading: false,
    this.isGoogleLoginSucceeded: false,
    this.isGoogleLoginFailed: false,

    this.isKakaoLoginLoading: false,
    this.isKakaoLoginSucceeded: false,
    this.isKakaoLoginFailed: false
  });

  factory IntroState.initial() => IntroState(isInitial: true);

  factory IntroState.facebookLoginLoading() => IntroState(isFacebookLoginLoading: true);
  factory IntroState.facebookLoginSucceeded() => IntroState(isFacebookLoginSucceeded: true);
  factory IntroState.facebookLoginFailed() => IntroState(isFacebookLoginFailed: true);

  factory IntroState.googleLoginLoading() => IntroState(isGoogleLoginLoading: true);
  factory IntroState.googleLoginSucceeded() => IntroState(isGoogleLoginSucceeded: true);
  factory IntroState.googleLoginFailed() => IntroState(isGoogleLoginFailed: true);

  factory IntroState.kakaoLoginLoading() => IntroState(isKakaoLoginLoading: true);
  factory IntroState.kakaoLoginSucceeded() => IntroState(isKakaoLoginSucceeded: true);
  factory IntroState.kakaoLoginFailed() => IntroState(isKakaoLoginFailed: true);
}