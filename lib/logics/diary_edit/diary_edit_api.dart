
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/logics/global/database_api.dart';
import 'package:mymovie/logics/global/firebase_api.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/utils/service_locator.dart';

class DiaryEditAPI {
  int _now;

  void _setTime() => _now = DateTime.now().millisecondsSinceEpoch;
  
  Future<void> storeDiary({@required DiaryModel diaryModel}) async {
    _setTime();
    await sl.get<FirebaseAPI>().addDiary(diaryModel: diaryModel, time: _now);
    await sl.get<DatabaseAPI>().addDiary(diary: diaryModel, time: _now);
    sl.get<CurrentUser>().addDiary(diary: diaryModel);
  }

  Future<void> updateDiary({@required DiaryModel diaryModel}) async {
    _setTime();
    await sl.get<FirebaseAPI>().updateDiary(diaryModel: diaryModel);
    await sl.get<DatabaseAPI>().updateDiary(diary: diaryModel);
    sl.get<CurrentUser>().updateDiary(diary: diaryModel);
  }
}