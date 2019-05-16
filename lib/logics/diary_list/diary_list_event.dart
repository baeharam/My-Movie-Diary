
import 'package:meta/meta.dart';

abstract class DiaryListEvent {}

class DiaryListEventStateClear extends DiaryListEvent {}

class DiaryListEventSnapPage extends DiaryListEvent {
  final int pageIndex;
  DiaryListEventSnapPage({@required this.pageIndex});
}