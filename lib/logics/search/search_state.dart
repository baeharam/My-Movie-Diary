
import 'package:meta/meta.dart';
import 'package:mymovie/models/movie_model.dart';

class SearchState {
  final bool isInitial;
  final bool isKeyboardOn;
  final bool isKeyboardOff;

  final bool isMovieDataFetched;
  final List<MovieModel> movieList;

  SearchState({
    this.isInitial: false,
    this.isKeyboardOn: false,
    this.isKeyboardOff: false,

    this.isMovieDataFetched: false,
    this.movieList: const []
  });

  factory SearchState.initial() => SearchState(isInitial: true);
  factory SearchState.keyboardOn() => SearchState(isKeyboardOn: true);
  factory SearchState.keyboardOff() => SearchState(isKeyboardOff: true);

  factory SearchState.movieFetched({@required List<MovieModel> movieList}) {
    return SearchState(
      isMovieDataFetched: true,
      movieList: movieList
    );
  }
}