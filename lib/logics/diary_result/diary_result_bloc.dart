
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mymovie/logics/diary_result/diary_result.dart';

class DiaryResultBloc extends Bloc<DiaryResultEvent,DiaryResultState> {

  static final DiaryResultAPI _api = DiaryResultAPI();

  @override
  DiaryResultState get initialState => DiaryResultState.initial();

  @override
  Stream<DiaryResultState> mapEventToState(DiaryResultEvent event) async*{
    if(event is DiaryResultEventStateClear) {
      yield DiaryResultState.initial();
    }

    if(event is DiaryResultEventDelete) {
      yield DiaryResultState.deleteLoading();
      try {
        await _api.deleteDiary(diaryModel: event.diary);
        yield DiaryResultState.deleteSucceeded();
      } catch(exception) {
        debugPrint('일기 삭제 실패: ${exception.toString()}');
        yield DiaryResultState.deleteFailed();
      }
    }
  }
}