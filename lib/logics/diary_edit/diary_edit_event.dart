
import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';

abstract class DiaryEditEvent {}

class DiaryEditEventStateClear extends DiaryEditEvent {}

class DiaryEditEventKeyboardOn extends DiaryEditEvent {}

class DiaryEditEventKeyboardOff extends DiaryEditEvent {}

class DiaryEditEventStarClick extends DiaryEditEvent {
  final double value;
  DiaryEditEventStarClick({@required this.value});
}

class DiaryEditEventTitleChange extends DiaryEditEvent {
  final String title;
  DiaryEditEventTitleChange({@required this.title});
}

class DiaryEditEventContentsChange extends DiaryEditEvent {
  final String contents;
  DiaryEditEventContentsChange({@required this.contents});
}

class DiaryEditEventComplete extends DiaryEditEvent {
  final DiaryModel diaryModel;
  DiaryEditEventComplete({@required this.diaryModel});
}

class DiaryEditEventUpdate extends DiaryEditEvent {
  final DiaryModel diaryModel;

  DiaryEditEventUpdate({@required this.diaryModel});
}