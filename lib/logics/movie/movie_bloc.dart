
import 'package:bloc/bloc.dart';
import 'package:mymovie/logics/movie/movie.dart';

class MovieBloc extends Bloc<MovieEvent,MovieState> {

  @override
  MovieState get initialState => MovieState.initial();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async*{
    if(event is MovieEventStateClear) {
      yield MovieState();
    }

    if(event is MovieEventMoreButtonClicked) {
      yield MovieState.moreButtonClicked();
    }

    if(event is MovieEventFoldButtonClicked) {
      yield MovieState.foldButtonClicked();
    }
  }
}