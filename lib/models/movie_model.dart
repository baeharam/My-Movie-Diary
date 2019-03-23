import 'package:meta/meta.dart';

class MovieModel {
  String posterLink;
  String title;
  String supervisor;
  String genre;
  int runningTime;

  MovieModel({
    @required this.posterLink,
    @required this.title,
    @required this.supervisor,
    @required this.genre,
    @required this.runningTime
  });
}