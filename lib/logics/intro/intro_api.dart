import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/utils/service_locator.dart';

class IntroAPI {
  static final FacebookLogin _facebookLogin = FacebookLogin();
  static final GoogleSignIn _googleLogin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> _setUID() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    sl.get<CurrentUser>().uid = user.uid;
  }

  Future<void> facebookAuthentication() async {
    FacebookLoginResult result = await _facebookLogin.logInWithReadPermissions(['email']);
    await _firebaseAuth.signInWithCredential(
      FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token
      )
    );
    await _setUID();
  }

  Future<void> googleAuthentication() async {
    GoogleSignInAccount googleSignInAccount = await _googleLogin.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    await _firebaseAuth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      )
    );
    await _setUID();
  }
}