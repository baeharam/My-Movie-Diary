import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/database_helper.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

class IntroAPI {
  static final FacebookLogin _facebookLogin = FacebookLogin();
  static final GoogleSignIn _googleLogin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  Database _db;

  Future<void> _dbInitialization() async {
    _db = await DatabaseHelper.instance.database;
  }

  Future<void> _setUID() async {
    debugPrint('사용자 UID 글로벌로 설정...');

    FirebaseUser user = await _firebaseAuth.currentUser();
    sl.get<CurrentUser>().uid = user.uid;
  }

  void _storeIntoCurrentUser({@required List<DiaryModel> diaryList}) {
    debugPrint('현재 사용자에 저장하는 중...');

    sl.get<CurrentUser>().diary = diaryList;
  }
  
  Future<void> _fetchDiaryFromLocal() async {
    debugPrint('로컬에서 일기 데이터 가져오는 중...');

    List<DiaryModel> diaryList = List<DiaryModel>();
    var diary = await _db.query(tableDiary,
      columns: [diaryColCode,diaryColTitle,diaryColContents,diaryColRating]);
    diary.forEach((map) async{
      MovieModel movie = await _fetchMovie(diary[0][diaryColCode]);
      diaryList.add(DiaryModel(
        title: map[diaryColTitle],
        contents: map[diaryColContents],
        rating: map[diaryColRating],
        movie: movie
      ));
    });
    _storeIntoCurrentUser(diaryList: diaryList);
  }

  Future<void> _fetchDiaryFromFirestore() async {
    debugPrint('서버에서 일기 데이터 가져오는 중...');

    List<DiaryModel> diaryList = List<DiaryModel>();
    QuerySnapshot diarySnapshot = await _firestore
      .collection(fMovieDiaryCol)
      .document(sl.get<CurrentUser>().uid)
      .collection(fMovieDiarySubCol)
      .getDocuments();
    diarySnapshot.documents.forEach((diary) async{
      MovieModel movie = await _fetchMovie(diary.data[fDiaryCodeField]);
      diaryList.add(DiaryModel(
        title: diary.data[fDiaryTitleField],
        contents: diary.data[fDiaryContentsField],
        rating: diary.data[fDiaryRatingField],
        movie: movie
      ));
    });
  }

  Future<bool> _isExistInLocal({@required String movieCode}) async {
    debugPrint('$movieCode가 로컬에 존재하는지 확인 중...');

    var result = await _db.query(tableMovie,where: '$movieColCode=$movieCode');
    return result.isNotEmpty ? true : false;
  }

  Future<MovieModel> _fetchMovie(String movieCode) async {
    return _fetchFromLocal(movieCode: movieCode);
  }

  Future<MovieModel> _fetchFromLocal({@required String movieCode}) async{
    debugPrint('$movieCode의 데이터 로컬에서 가져오는 중...');

    var defaultInfo = await _db.query(tableMovie,
      columns: [movieColMainPhoto,movieColTitle,movieColDescription,movieColLink,
        movieColMainActor,movieColMainDirector,movieColPubdate,movieColThumnail,
        movieColUserRating,movieColCode],
      where: '$movieColCode=$movieCode');
    var stillCutList = await _db.query(tableStillcut,
      columns: [stillcutColPhoto],
      where: '$stillcutColCode=$movieCode');
    var actorList = await _db.query(tableActor,
      columns: [actorColLevel,actorColName,actorColRole,actorColThumbnail],
      where: '$actorColCode=$movieCode');
    var trailerList = await _db.query(tableTrailer,
      columns: [trailerColCode,trailerColVideo],
      where: '$trailerColCode=$movieCode');
    return MovieModel.fromLocalDB(
      movieDefault: defaultInfo[0],
      movieStillcutList: stillCutList,
      movieActorList: actorList,
      movieTrailerList: trailerList
    );
  }

  Future<bool> _isRecentLocal() async {
    debugPrint('서버와 로컬의 업데이트 시간이 같은지 확인...');

    DocumentSnapshot firestoreTimeSnapshot = await _firestore
      .collection(fMovieDiaryCol)
      .document(sl.get<CurrentUser>().uid).get();
    SharedPreferences sf = await SharedPreferences.getInstance();

    int serverTime = firestoreTimeSnapshot.data==null ? -1 : firestoreTimeSnapshot.data[fRecentUpdatedTimeField];
    int localTime = sf.getInt(sfRecentUpdatedTime) ?? -1;

    if(localTime <= serverTime) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> facebookAuthentication() async {
    debugPrint('페이스북 로그인...');

    FacebookLoginResult result = await _facebookLogin.logInWithReadPermissions(['email']);
    await _firebaseAuth.signInWithCredential(
      FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token
      )
    );
    await _setUID();
    await _dbInitialization();
    if(await _isRecentLocal()) {
      await _fetchDiaryFromLocal();
    } else {
      await _fetchDiaryFromFirestore();
    }
  }

  Future<void> googleAuthentication() async {
    debugPrint('구글 로그인...');

    GoogleSignInAccount googleSignInAccount = await _googleLogin.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    await _firebaseAuth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      )
    );
    await _setUID();
    await _dbInitialization();
    if(await _isRecentLocal()) {
      await _fetchDiaryFromLocal();
    } else {
      await _fetchDiaryFromFirestore();
    }
  }
}