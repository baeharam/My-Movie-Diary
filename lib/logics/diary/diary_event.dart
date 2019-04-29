
import 'package:meta/meta.dart';

abstract class DiaryEvent {}

class DiaryEventStateClear extends DiaryEvent {}

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