import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory MovieModel.fromSnapshot(DocumentSnapshot snapshot){
    List<String> stillcutList = List<String>();
    for(dynamic stillcutLink in snapshot.data[fMovieStillcutListField]){
      stillcutList.add(stillcutLink as String);
    }
    List<String> trailerList = List<String>();
    for(dynamic trailerLink in snapshot.data[fMovieTrailerListField]){
      trailerList.add(trailerLink as String);
    }
    return MovieModel._(
      link: snapshot.data[fMovieLinkField] as String,
      movieCode: snapshot.data[fMovieCodeField] as String,
      thumbnail: snapshot.data[fMovieThumbnailField] as String,
      title: snapshot.data[fMovieTitleField] as String,
      mainDirector: snapshot.data[fMovieMainDirectorField] as String,
      mainActor: snapshot.data[fMovieMainActorField] as String,
      userRating: snapshot.data[fMovieUserRatingField] as String,
      pubDate: snapshot.data[fMoviePubdateField] as String,
      description: snapshot.data[fMovieDescriptionField] as String,
      mainPhoto: snapshot.data[fMovieMainPhotoField] as String,
      stillcutList: stillcutList,
      trailerList: trailerList
    );
  }
  
  factory MovieModel.fromMap(Map<String,dynamic> map) {
    List<String> stillcutList = List<String>();
    for(dynamic stillcutLink in map[fMovieStillcutListField]){
      stillcutList.add(stillcutLink as String);
    }
    List<String> trailerList = List<String>();
    for(dynamic trailerLink in map[fMovieTrailerListField]){
      trailerList.add(trailerLink as String);
    }

    return MovieModel._(
      link: map[fMovieLinkField] as String,
      movieCode: map[fMovieCodeField] as String,
      thumbnail: map[fMovieThumbnailField] as String,
      title: map[fMovieTitleField] as String,
      mainDirector: map[fMovieMainDirectorField] as String,
      mainActor: map[fMovieMainActorField] as String,
      userRating: map[fMovieUserRatingField] as String,
      pubDate: map[fMoviePubdateField] as String,
      description: map[fMovieDescriptionField] as String,
      mainPhoto: map[fMovieMainPhotoField] as String,
      stillcutList: stillcutList,
      trailerList: trailerList
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
    List<ActorModel> actors = List<ActorModel>();
    for(var actor in actorList) {
      actors.add(ActorModel.fromMap(actor));
    }
    this.actorList = actors;
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