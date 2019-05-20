
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mymovie/logics/diary_edit/diary_edit.dart';

class DiaryEditBloc extends Bloc<DiaryEditEvent,DiaryEditState> {

  static final DiaryEditAPI _diaryAPI = DiaryEditAPI();

  @override
  DiaryEditState get initialState => DiaryEditState.initial();

  @override
  Stream<DiaryEditState> mapEventToState(DiaryEditEvent event) async*{

    if(event is DiaryEditEventStateClear) {
      yield DiaryEditState.initial();
    }

    if(event is DiaryEditEventComplete) {
      yield DiaryEditState.completeLoading();
      try {
        await _diaryAPI.storeDiary(diaryModel: event.diaryModel);
        yield DiaryEditState.completeSucceeded(diaryModel: event.diaryModel);
      } catch(exception){
        debugPrint('일기 Firestore에 저장 실패: ${exception.toString()}');
        yield DiaryEditState.completeFailed();
      }
    }

    if(event is DiaryEditEventUpdate) {
      yield DiaryEditState.updateLoading();
      try {
        await _diaryAPI.updateDiary(diaryModel: event.diaryModel);
        yield DiaryEditState.updateSucceeded(diaryModel: event.diaryModel);
      } catch(exception){
        debugPrint('일기 Firestore에 업데이트 실패: ${exception.toString()}');
        yield DiaryEditState.updateFailed();
      }
    }

    if(event is DiaryEditEventKeyboardOn) {
      yield currentState.copyWith(isKeyboardOn: true,isKeyboardOff: false);
    }
    if(event is DiaryEditEventKeyboardOff) {
      yield currentState.copyWith(isKeyboardOff: true,isKeyboardOn: false);
    }

    if(event is DiaryEditEventStarClick) {
      yield currentState.copyWith(star: event.value);
    }

    if(event is DiaryEditEventTitleChange) {
      yield currentState.copyWith(
        title: event.title,
        isTitleNotEmpty: true
      );
    }

    if(event is DiaryEditEventContentsChange) {
      yield currentState.copyWith(
        feeling: event.contents,
        isFeelingNotEmpty: true
      );
    }

  }
}