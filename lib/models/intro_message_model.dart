
import 'package:meta/meta.dart';

import 'diary_model.dart';

class IntroMessageModel {
  final String diaryTitle;
  final String movieTitle;
  final String pubDate;

  IntroMessageModel({
    @required this.diaryTitle,
    @required this.movieTitle,
    @required this.pubDate
  });

  factory IntroMessageModel.fromDiary({@required DiaryModel diary}) {
    return IntroMessageModel(
      diaryTitle: diary.title,
      movieTitle: diary.movie.title,
      pubDate: diary.movie.pubDate
    );
  }
}