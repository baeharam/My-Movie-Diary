import 'package:meta/meta.dart';
import 'package:mymovie/models/actor_model.dart';

class MovieModel {
  final String link;
  final String movieCode;
  final String thumbnail;
  final String title;
  final String pubDate;
  final String director;
  final String actor;
  final String userRating;

  String description;
  String realPhoto;
  List<String> subImages;
  List<ActorModel> actors;

  MovieModel._({
    @required this.link,
    @required this.movieCode,
    @required this.thumbnail,
    @required this.title,
    @required this.director,
    @required this.actor,
    @required this.userRating,
    @required this.pubDate,

    this.description,
    this.realPhoto,
    this.subImages,
    this.actors
  }) : assert(link!=null),
       assert(movieCode!=null),
       assert(thumbnail!=null),
       assert(title!=null),
       assert(director!=null),
       assert(actor!=null),
       assert(userRating!=null);

  factory MovieModel.fromJson(Map<String,dynamic> json) {
    String movieTitle = (json['title'] as String)
      .replaceAll('<b>', '')
      .replaceAll('</b>', '')
      .replaceAll('&amp;', '&');
    String movieDirector = (json['director'] as String)
      .split('|')[0]
      .replaceAll('<b>', '')
      .replaceAll('</b>', '');
    String movieActor = (json['actor'] as String)
      .split('|')[0];
    String movieCode = (json['link'] as String)
      .split('=')[1];
    return MovieModel._(
      link: json['link'] as String,
      movieCode: movieCode,
      thumbnail: json['image'] as String,
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
    = 'link: $link\n'
      'movieCode: $movieCode\n'
      'thumbnail: $thumbnail\n'
      'title: $title\n'
      'director: $director\n'
      'actor: $actor\n'
      'userRating: $userRating\n'
      'pubDate: $pubDate\n'
      'description: $description\n'
      'realPhoto: $realPhoto\n';
    return result;
  }
}