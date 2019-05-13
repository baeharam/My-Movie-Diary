
import 'package:bloc/bloc.dart';
import 'package:mymovie/logics/diary/diary.dart';

class DiaryBloc extends Bloc<DiaryEvent,DiaryState> {

  @override
  DiaryState get initialState => DiaryState.initial();


  @override
  Stream<DiaryState> mapEventToState(DiaryEvent event) async*{

    if(event is DiaryEventStateClear) {
      yield DiaryState.initial();
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