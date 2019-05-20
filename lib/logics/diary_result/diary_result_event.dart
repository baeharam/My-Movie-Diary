
import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';

abstract class DiaryResultEvent {}

class DiaryResultEventStateClear extends DiaryResultEvent {}
class DiaryResultEventDelete extends DiaryResultEvent {
  final DiaryModel diary;

  DiaryResultEventDelete({@required this.diary});
}