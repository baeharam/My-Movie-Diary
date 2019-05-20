
import 'dart:math';

import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/models/intro_message_model.dart';
import 'package:mymovie/resources/constants.dart';

class CurrentUser {
  String uid = '';
  List<DiaryModel> diaryList = List<DiaryModel>();

  void setDiaryList({@required List<DiaryModel> diaryList}) => this.diaryList = diaryList;

  void addDiary({@required DiaryModel diary}) => this.diaryList.add(diary);
  void updateDiary({@required DiaryModel diary}) {
    diaryList
      .where((existing) => existing.movieCode==diary.movieCode)
      .forEach((find) => find = diary);
  }
  void deleteDiary({@required DiaryModel diary}) 
    => this.diaryList.removeWhere((diaryModel) => diaryModel.movieCode==diary.movieCode);

  IntroMessageModel getRandomIntro() {
    if(isDiaryEmpty()) {
      return defaultIntro;
    } else {
      DiaryModel random = _getRandomDiary();
      return IntroMessageModel(
        diaryTitle: random.diaryTitle,
        pubDate: random.moviePubDate,
        movieTitle: random.movieTitle
      );
    }
  }

  DiaryModel _getRandomDiary() => diaryList[Random().nextInt(diaryList.length)];

  bool isDiaryEmpty() => diaryList.isEmpty;
  int get diaryLength => diaryList.length;
}