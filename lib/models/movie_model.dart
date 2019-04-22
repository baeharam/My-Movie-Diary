import 'package:meta/meta.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/resources/constants.dart';

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

  factory MovieModel.fromLocalDB({
    @required Map<String,dynamic> movieDefault,
    @required List<Map<String,dynamic>> movieStillcutList,
    @required List<Map<String,dynamic>> movieActorList,
    @required List<Map<String,dynamic>> movieTrailerList
  }) {

    List<String> _stillCutList = List<String>();
    movieStillcutList.forEach((map) => _stillCutList.add(map[stillcutColPhoto]));

    List<ActorModel> _actorList = List<ActorModel>();
    movieActorList.forEach((map) => _actorList.add(ActorModel.fromMap(map)));

    List<String> _trailerList = List<String>();
    movieTrailerList.forEach((map) => _trailerList.add(map[trailerColVideo]));

    return MovieModel._(
      link: movieDefault[movieColLink],
      movieCode: movieDefault[movieColCode],
      thumbnail: movieDefault[movieColThumnail],
      title: movieDefault[movieColTitle],
      mainDirector: movieDefault[movieColMainDirector],
      mainActor: movieDefault[movieColMainActor],
      userRating: movieDefault[movieColUserRating],
      pubDate: movieDefault[movieColPubdate],
      description: movieDefault[movieColDescription],
      mainPhoto: movieDefault[movieColMainPhoto],
      stillcutList: _stillCutList,
      actorList: _actorList,
      trailerList: _trailerList
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