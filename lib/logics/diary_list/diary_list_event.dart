
import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';

abstract class DiaryListEvent {}

class DiaryListEventStateClear extends DiaryListEvent {}

class DiaryListEventSnapPage extends DiaryListEvent {
  final int pageIndex;
  DiaryListEventSnapPage({@required this.pageIndex});
}

class DiaryListEventDelete extends DiaryListEvent {
  final DiaryModel diary;

  DiaryListEventDelete({@required this.diary});
}