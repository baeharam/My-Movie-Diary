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

  String get docName => this.movieCode+"-"+this.title;
  
  factory MovieModel.fromMap(Map<String,dynamic> map) {
    return MovieModel._(
      link: map[fMovieLinkField],
      movieCode: map[fMovieCodeField],
      thumbnail: map[fMovieThumbnailField],
      title: map[fMovieTitleField],
      mainDirector: map[fMovieMainDirectorField],
      mainActor: map[fMovieMainActorField],
      userRating: map[fMovieUserRatingField],
      pubDate: map[fMoviePubdateField],
      description: map[fMovieDescriptionField],
      mainPhoto: map[fMovieMainPhotoField],
      stillcutList: map[fMovieStillcutListField],
      trailerList: map[fMovieTrailerListField]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      fMovieLinkField: this.link,
      fMovieCodeField: this.movieCode,
      fMovieThumbnailField: this.thumbnail,
      fMovieTitleField: this.title,
      fMovieMainDirectorField: this.mainDirector,
      fMovieMainActorField: this.mainActor,
      fMovieUserRatingField: this.userRating,
      fMoviePubdateField: this.pubDate,
      fMovieDescriptionField: this.description,
      fMovieMainPhotoField: this.mainPhoto,
      fMovieStillcutListField: this.stillcutList,
      fMovieTrailerListField: this.trailerList
    };
  }

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

  void addActorList(List<Map<String,dynamic>> actorList){
    for(var actor in actorList) {
      this.actorList.add(ActorModel.fromMap(actor));
    }
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