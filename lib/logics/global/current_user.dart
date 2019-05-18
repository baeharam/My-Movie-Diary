
import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';

class CurrentUser {
  String uid = '';
  List<DiaryModel> diaryList = List<DiaryModel>();

  void setDiaryList({@required List<DiaryModel> diaryList}) => this.diaryList = diaryList;
  void addDiary({@required DiaryModel diary}) => this.diaryList.add(diary);
  bool isDiaryEmpty() => diaryList.isEmpty;
  int get diaryLength => diaryList.length;
}