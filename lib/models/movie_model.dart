import 'package:meta/meta.dart';

class MovieModel {
  String image;
  String title;
  String pubDate;
  String director;
  String actor;
  String userRating;

  MovieModel({
    @required this.image,
    @required this.title,
    @required this.director,
    @required this.actor,
    @required this.userRating,
    @required this.pubDate
  });

  factory MovieModel.fromJson(Map<String,dynamic> json) {
    String movieTitle = (json['title'] as String)
      .replaceAll('<b>', '')
      .replaceAll('</b>', '');
    String movieDirector = (json['director'] as String)
      .split('|')[0];
    String movieActor = (json['actor'] as String)
      .split('|')[0];
    return MovieModel(
      image: json['image'] as String,
      title: movieTitle,
      director: movieDirector,
      actor: movieActor,
      userRating: json['userRating'] as String,
      pubDate: json['pubDate'] as String
    );
  }

  @override
  String toString() {
    String result
    = 'image: $image\n'
      'title: $title\n'
      'director: $director\n'
      'actor: $actor\n'
      'userRating: $userRating\n';
    return result;
  }
}