import 'package:meta/meta.dart';
import 'package:mymovie/models/movie_model.dart';

abstract class SearchEvent {}

class SearchEventStateClear extends SearchEvent {}

class SearchEventKeyboardOn extends SearchEvent {}

class SearchEventKeyboardOff extends SearchEvent {}

class SearchEventTextChanged extends SearchEvent {
  final String text;
  SearchEventTextChanged({@required this.text});
}

class SearchEventMovieClick extends SearchEvent {
  final MovieModel movie;
  SearchEventMovieClick({@required this.movie});
}