
import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';

abstract class DiaryEvent {}

class DiaryEventStateClear extends DiaryEvent {}

class DiaryEventKeyboardOn extends DiaryEvent {}

class DiaryEventKeyboardOff extends DiaryEvent {}

class DiaryEventStarClick extends DiaryEvent {
  final double value;
  DiaryEventStarClick({@required this.value});
}

class DiaryEventTitleChange extends DiaryEvent {
  final String title;
  DiaryEventTitleChange({@required this.title});
}

class DiaryEventFeelingChange extends DiaryEvent {
  final String feeling;
  DiaryEventFeelingChange({@required this.feeling});
}

class DiaryEventComplete extends DiaryEvent {
  final DiaryModel diaryModel;
  DiaryEventComplete({@required this.diaryModel});
}