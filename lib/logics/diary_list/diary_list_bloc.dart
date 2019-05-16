
import 'package:bloc/bloc.dart';
import 'package:mymovie/logics/diary_list/diary_list.dart';

class DiaryListBloc extends Bloc<DiaryListEvent,DiaryListState> {

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
  }
}