
import 'package:bloc/bloc.dart';
import 'package:mymovie/logics/diary/diary.dart';

class DiaryBloc extends Bloc<DiaryEvent,DiaryState> {

  @override
  DiaryState get initialState => DiaryState.initial();

  @override
  Stream<DiaryState> mapEventToState(DiaryEvent event) async*{
    if(event is DiaryEventStateClear) {
      yield DiaryState();
    }

    if(event is DiaryEventStarClick) {
      yield DiaryState.starClicked(value: event.value);
    }
  }
}