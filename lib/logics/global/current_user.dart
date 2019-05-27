
import 'dart:math';

import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';

class CurrentUser {
  String uid = '';
  List<DiaryModel> diaryList = List<DiaryModel>();

  void setDiaryList({@required List<DiaryModel> diaryList}) => this.diaryList = diaryList;

  void addDiary({@required DiaryModel diary}) => this.diaryList.add(diary);
  void updateDiary({@required DiaryModel diary}) {
    for(DiaryModel existing in diaryList){
      if(existing.movieCode==diary.movieCode){
        existing = diary;
        break;
      }
    }
  }
  void deleteDiary({@required DiaryModel diary}) 
    => this.diaryList.removeWhere((diaryModel) => diaryModel.movieCode==diary.movieCode);

  DiaryModel getRandomDiary() => 
    isDiaryEmpty() ? null : diaryList[Random().nextInt(diaryList.length)];

  bool isDiaryEmpty() => diaryList.isEmpty;
  int get diaryLength => diaryList.length;
}