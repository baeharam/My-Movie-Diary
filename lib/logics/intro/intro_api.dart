import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class IntroAPI {
  static final FlutterKakaoLogin _kakaoLogin = FlutterKakaoLogin();
  static final GoogleSignIn _googleLogin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> kakaoAuthentication() async {
    _kakaoLogin.logIn();
  }

  Future<void> googleAuthentication() async {
    _googleLogin.signIn();
  }
}