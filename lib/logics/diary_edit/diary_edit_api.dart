
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/logics/global/database_api.dart';
import 'package:mymovie/logics/global/firebase_api.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryEditAPI {
  DateTime _now;

  void setTime() => _now = DateTime.now();

  Future<void> storeIntoFirestore({@required DiaryModel diaryModel}) async{
    debugPrint('서버에 일기 저장 중...');

    await sl.get<FirebaseAPI>().storeDiary(diaryModel: diaryModel, time: _now.millisecondsSinceEpoch);
  }

  Future<void> storeIntoLocal({@required DiaryModel diaryModel}) async {
    debugPrint('로컬에 일기 저장 중...');
    SharedPreferences sf = await SharedPreferences.getInstance();
    await sf.setInt(sfRecentUpdatedTime, _now.millisecondsSinceEpoch);
    await sl.get<DatabaseAPI>().putDiary(diary: diaryModel);
  }

  void storeIntoCurrentUser({@required DiaryModel diaryModel}) {
    debugPrint('현재 사용자에 일기 저장 중...');

    sl.get<CurrentUser>().addDiary(diary: diaryModel);
  }
}