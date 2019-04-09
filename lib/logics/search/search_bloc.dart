import 'package:bloc/bloc.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:rxdart/rxdart.dart';
import 'search.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState> {

  static final SearchAPI _api = SearchAPI();
  
  @override
  SearchState get initialState => SearchState.initial();

  @override
  Stream<SearchEvent> transform(Stream<SearchEvent> events) {
    final Observable<SearchEvent> originalStream = events as Observable<SearchEvent>;
    final Observable<SearchEvent> nonDebounceStream = originalStream.where((event){
      return (event is! SearchEventTextChanged);
    });
    final Observable<SearchEvent> debounceStream = originalStream.where((event){
      return (event is SearchEventTextChanged);
    }).debounce(const Duration(milliseconds: 300));
    
    return nonDebounceStream.mergeWith([debounceStream]);
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async*{

    if(event is SearchEventStateClear) {
      yield SearchState();
    }

    if(event is SearchEventKeyboardOn) {
      yield SearchState.keyboardOn();
    }
    if(event is SearchEventKeyboardOff) {
      yield SearchState.keyboardOff();
    }

    if(event is SearchEventTextChanged) {
      yield SearchState.movieAPICallLoading();
      try {
        List<MovieModel> movieList = await _api.getMovieList(movieTitle: event.text);
        yield SearchState.movieAPICallSucceeded(movieList: movieList);
      } catch(exception) {
        print('영화 API 호출 실패: ${exception.toString()}');
        yield SearchState.movieAPICallFailed();
      }
    }

    if(event is SearchEventMovieClick) {
      try {
        yield SearchState.movieCrawlLoading(movieCode: event.movie.movieCode);
        MovieModel movie = await _api.getMoreInfoOfMovie(movie: event.movie);
        yield SearchState.movieCrawlSucceeded(movie: movie);
      } catch(exception) {
        print('영화 크롤링 실패: ${exception.toString()}');
        yield SearchState.movieCrawlFailed();
      }
    }
  }
}