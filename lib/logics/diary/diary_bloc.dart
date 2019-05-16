
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mymovie/logics/diary/diary.dart';

class DiaryBloc extends Bloc<DiaryEvent,DiaryState> {

  static final DiaryAPI _diaryAPI = DiaryAPI();

  @override
  DiaryState get initialState => DiaryState.initial();

  @override
  Stream<DiaryState> mapEventToState(DiaryEvent event) async*{

    if(event is DiaryEventStateClear) {
      yield DiaryState.initial();
    }

    if(event is DiaryEventComplete) {
      yield DiaryState.completeLoading();
      try {
        _diaryAPI.setTime();
        await _diaryAPI.storeIntoFirestore(diaryModel: event.diaryModel);
        await _diaryAPI.storeIntoLocal(diaryModel: event.diaryModel);
        _diaryAPI.storeIntoCurrentUser(diaryModel: event.diaryModel);
        yield DiaryState.completeSucceeded(diaryModel: event.diaryModel);
      } catch(exception){
        debugPrint('일기 Firestore에 저장 실패: ${exception.toString()}');
        yield DiaryState.completeFailed();
      }
    }

    if(event is DiaryEventKeyboardOn) {
      yield currentState.copyWith(isKeyboardOn: true,isKeyboardOff: false);
    }
    if(event is DiaryEventKeyboardOff) {
      yield currentState.copyWith(isKeyboardOff: true,isKeyboardOn: false);
    }

    if(event is DiaryEventStarClick) {
      yield currentState.copyWith(star: event.value);
    }

    if(event is DiaryEventTitleChange) {
      yield currentState.copyWith(
        title: event.title,
        isTitleNotEmpty: true
      );
    }

    if(event is DiaryEventFeelingChange) {
      yield currentState.copyWith(
        feeling: event.feeling,
        isFeelingNotEmpty: true
      );
    }

  }
}