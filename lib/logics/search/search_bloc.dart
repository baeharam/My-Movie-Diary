import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'search.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState> {

  static final _api = SearchAPI();
  
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
    }).debounce(const Duration(milliseconds: 500));
    
    return nonDebounceStream.mergeWith([debounceStream]);
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async*{
    if(event is SearchEventKeyboardOn) {
      yield SearchState.keyboardOn();
    }
    if(event is SearchEventKeyboardOff) {
      yield SearchState.keyboardOff();
    }

    if(event is SearchEventTextChanged) {
      yield SearchState.movieFetched(movieList: 
        await _api.getMovieList(movieTitle: event.text));
    }
  }
}