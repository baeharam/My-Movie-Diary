
import 'package:meta/meta.dart';

abstract class DiaryEvent {}

class DiaryEventStateClear extends DiaryEvent {}

class DiaryEventStarClick extends DiaryEvent {
  final double value;

  DiaryEventStarClick({@required this.value});
}