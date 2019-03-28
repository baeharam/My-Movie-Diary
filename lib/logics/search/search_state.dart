
import 'package:meta/meta.dart';
import 'package:mymovie/models/movie_model.dart';

class SearchState {
  final bool isInitial;
  final bool isKeyboardOn;
  final bool isKeyboardOff;

  final bool isMovieAPICallLoading;
  final bool isMovieAPICallSucceeded;
  final bool isMovieAPICallFailed;
  final List<MovieModel> movieList;

  final bool isMovieCrawlLoading;
  final bool isMovieCrawlSucceeded;
  final bool isMOvieCrawlFailed;
  final MovieModel clickedMovie;

  SearchState({
    this.isInitial: false,
    this.isKeyboardOn: false,
    this.isKeyboardOff: false,

    this.isMovieAPICallLoading: false,
    this.isMovieAPICallSucceeded: false,
    this.isMovieAPICallFailed: false,
    this.movieList: const [],

    this.isMovieCrawlLoading: false,
    this.isMovieCrawlSucceeded: false,
    this.isMOvieCrawlFailed: false,
    this.clickedMovie
  });

  factory SearchState.initial() => SearchState(isInitial: true);
  factory SearchState.keyboardOn() => SearchState(isKeyboardOn: true);
  factory SearchState.keyboardOff() => SearchState(isKeyboardOff: true);

  factory SearchState.movieAPICallLoading() => SearchState(isMovieAPICallLoading: true);
  factory SearchState.movieAPICallSucceeded({@required List<MovieModel> movieList}) {
    return SearchState(
      isMovieAPICallSucceeded: true,
      movieList: movieList
    );
  }
  factory SearchState.movieAPICallFailed() => SearchState(isMovieAPICallFailed: true);

  factory SearchState.movieCrawlLoading() => SearchState(isMovieCrawlLoading: true);
  factory SearchState.movieCrawlSucceeded({@required MovieModel movie}) {
    return SearchState(
      isMovieCrawlSucceeded: true,
      clickedMovie: movie
    );
  }
  factory SearchState.movieCrawlFailed() => SearchState(isMOvieCrawlFailed: true);
}