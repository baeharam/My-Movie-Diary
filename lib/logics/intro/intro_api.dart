import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/logics/global/database_api.dart';
import 'package:mymovie/logics/global/firebase_api.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/utils/service_locator.dart';

class IntroAPI {
  final FacebookLogin _facebookLogin = FacebookLogin();
  final GoogleSignIn _googleLogin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();

  Future<void> _dataInitialization() async {
    await sl.get<FirebaseAPI>().setUID();
    await sl.get<DatabaseAPI>().initialization();
    await _fetchDiary();
  }

  Future<void> _fetchDiary() async {
    if(await sl.get<DatabaseAPI>().isDiaryCached()){
      List<DiaryModel> diaryList = await sl.get<DatabaseAPI>().getAllDiary();
      sl.get<CurrentUser>().setDiaryList(diaryList: diaryList);
    }
    else{
      List<DiaryModel> diaryList = await sl.get<FirebaseAPI>().getAllDiary();
      sl.get<DatabaseAPI>().addAllDiary(diaryList: diaryList);
      sl.get<CurrentUser>().setDiaryList(diaryList: diaryList);
    }
  }

  Future<void> kakaoAuthentication() async {
    debugPrint('카카오 로그인...');

    KakaoLoginResult result = await kakaoSignIn.getUserMe();
    assert(result.status == KakaoLoginStatus.loggedIn);
    

    final KakaoAccessToken token = await kakaoSignIn.currentAccessToken;
    final dynamic customToken = 
      await sl.get<FirebaseAPI>().cloudFunctions.call(
        functionName: 'generateCustomToken',
        parameters: {'uid': token.token}
      );
    await sl.get<FirebaseAPI>().firebaseAuth.signInWithCustomToken(token: (customToken as String));
    await _dataInitialization();
  }

  Future<void> facebookAuthentication() async {
    debugPrint('페이스북 로그인...');

    FacebookLoginResult result = await _facebookLogin.logInWithReadPermissions(['email']);
    await sl.get<FirebaseAPI>().firebaseAuth.signInWithCredential(
      FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token
      )
    );
    await _dataInitialization();
  }

  Future<void> googleAuthentication() async {
    debugPrint('구글 로그인...');

    GoogleSignInAccount googleSignInAccount = await _googleLogin.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    await sl.get<FirebaseAPI>().firebaseAuth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      )
    );
    await _dataInitialization();
  }
}