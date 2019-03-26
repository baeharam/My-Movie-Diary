import 'package:bloc/bloc.dart';
import 'search.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState> {

  static final _api = SearchAPI();
  
  @override
  SearchState get initialState => SearchState.initial();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async*{
    if(event is SearchEventKeyboardChanged) {
      yield SearchState.keyboardChanged(isKeyboardOn: event.isKeyboardOn);
    }
  }
}