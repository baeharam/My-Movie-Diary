
import 'package:meta/meta.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/logics/global/database_api.dart';
import 'package:mymovie/logics/global/firebase_api.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/utils/service_locator.dart';

class DiaryResultAPI {
  Future<void> deleteDiary({@required DiaryModel diaryModel}) async {
    await sl.get<FirebaseAPI>().deleteDiary(diary: diaryModel);
    await sl.get<DatabaseAPI>().deleteDiary(diary: diaryModel);
    sl.get<CurrentUser>().deleteDiary(diary: diaryModel);
  }
}