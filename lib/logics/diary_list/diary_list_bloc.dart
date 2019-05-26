
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mymovie/logics/diary_list/diary_list.dart';

class DiaryListBloc extends Bloc<DiaryListEvent,DiaryListState> {

  static final DiaryListAPI _api = DiaryListAPI();

  @override
  DiaryListState get initialState => DiaryListState.initial();

  @override
  Stream<DiaryListState> mapEventToState(DiaryListEvent event) async*{
    if(event is DiaryListEventStateClear) {
      yield DiaryListState.initial();
    }

    if(event is DiaryListEventSnapPage) {
      yield DiaryListState.pageSnapped(index: event.pageIndex);
    }

    if(event is DiaryListEventDelete) {
      yield DiaryListState.deleteLoading();
      try {
        await _api.deleteDiary(diaryModel: event.diary);
        yield DiaryListState.deleteSucceeded();
      } catch(exception) {
        debugPrint('일기 삭제 실패: ${exception.toString()}');
        yield DiaryListState.deleteFailed();
      }
    }
  }
}