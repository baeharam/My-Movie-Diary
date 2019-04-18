import 'package:meta/meta.dart';
import 'package:mymovie/models/actor_model.dart';

class MovieModel {
  final String link;
  final String movieCode;
  final String thumbnail;
  final String title;
  final String pubDate;
  final String mainDirector;
  final String mainActor;
  final String userRating;

  String description;
  String mainPhoto;
  List<String> stillcutList;
  List<ActorModel> actorList;
  List<String> trailerList;

  MovieModel._({
    @required this.link,
    @required this.movieCode,
    @required this.thumbnail,
    @required this.title,
    @required this.mainDirector,
    @required this.mainActor,
    @required this.userRating,
    @required this.pubDate,

    this.description,
    this.mainPhoto,
    this.stillcutList,
    this.actorList,
    this.trailerList
  }) : assert(link!=null),
       assert(movieCode!=null),
       assert(thumbnail!=null),
       assert(title!=null),
       assert(mainDirector!=null),
       assert(mainActor!=null),
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
      .split('|')[0]
      .replaceAll('<b>', '')
      .replaceAll('</b>', '');
    String movieCode = (json['link'] as String)
      .split('=')[1];
    return MovieModel._(
      link: json['link'] as String,
      movieCode: movieCode,
      thumbnail: json['image'] as String,
      title: movieTitle,
      mainDirector: movieDirector,
      mainActor: movieActor,
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
      'director: $mainDirector\n'
      'actor: $mainActor\n'
      'userRating: $userRating\n'
      'pubDate: $pubDate\n'
      'description: $description\n'
      'realPhoto: $mainPhoto\n';
    return result;
  }
}