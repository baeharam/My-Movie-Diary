import 'package:meta/meta.dart';
import 'package:mymovie/models/movie_model.dart';

class DiaryModel {
  final MovieModel movie;
  final String title;
  final String contents;
  final double rating;

  DiaryModel({
    @required this.movie,
    @required this.title,
    @required this.contents,
    @required this.rating
  }) : assert(movie!=null),
       assert(title!=null),
       assert(contents!=null),
       assert(rating!=null);
}