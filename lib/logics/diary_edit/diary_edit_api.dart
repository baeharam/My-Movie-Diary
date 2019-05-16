
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/database_helper.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryEditAPI {
  final Firestore _firestore = Firestore.instance;
  DateTime _now;

  void setTime() => _now = DateTime.now();

  Future<void> storeIntoFirestore({@required DiaryModel diaryModel}) async{
    debugPrint('서버에 일기 저장 중...');

    DocumentReference userRef = _firestore
      .collection(fMovieDiaryCol)
      .document(sl.get<CurrentUser>().uid);

    DocumentReference diaryRef = _firestore
      .collection(fMovieDiaryCol)
      .document(sl.get<CurrentUser>().uid)
      .collection(fMovieDiarySubCol)
      .document(diaryModel.movie.movieCode+'-'+diaryModel.movie.title);

    WriteBatch batch = _firestore.batch();

    batch.setData(diaryRef, {
      fDiaryTitleField: diaryModel.title,
      fDiaryContentsField: diaryModel.contents,
      fDiaryRatingField: diaryModel.rating,
      fDiaryImageField: diaryModel.movie.mainPhoto,
      fDiaryCodeField: diaryModel.movie.movieCode
    });

    batch.setData(userRef, {
      fRecentUpdatedTimeField: _now.millisecondsSinceEpoch
    });

    await batch.commit();
  }

  Future<void> storeIntoLocal({@required DiaryModel diaryModel}) async {
    debugPrint('로컬에 일기 저장 중...');

    Database db = await DatabaseHelper.instance.database;
    SharedPreferences sf = await SharedPreferences.getInstance();

    await db.insert(tableDiary, {
      diaryColCode: diaryModel.movie.movieCode,
      diaryColContents: diaryModel.contents,
      diaryColRating: diaryModel.rating,
      diaryColTitle: diaryModel.title
    });

    sf.setInt(sfRecentUpdatedTime, _now.millisecondsSinceEpoch);
  }

  void storeIntoCurrentUser({@required DiaryModel diaryModel}) {
    debugPrint('현재 사용자에 일기 저장 중...');

    sl.get<CurrentUser>().diary.add(diaryModel);
  }
}