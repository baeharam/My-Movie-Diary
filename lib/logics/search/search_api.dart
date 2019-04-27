import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:mymovie/resources/constants.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';
import 'package:mymovie/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SearchAPI {

  static Database _db;

  Future<void> _dbInitialization() async => _db = await DatabaseHelper.instance.database;

  Future<void> _storeMovieDefaultInfo(MovieModel movie) async {
    debugPrint('로컬 DB에 기본정보 저장중...');

    await _db.insert(tableMovie, {
      movieColLink: movie.link,
      movieColCode: movie.movieCode,
      movieColThumnail: movie.thumbnail,
      movieColTitle: movie.title,
      movieColPubdate: movie.pubDate,
      movieColMainDirector: movie.mainDirector,
      movieColMainActor: movie.mainActor,
      movieColUserRating: movie.userRating,
      movieColDescription: movie.description,
      movieColMainPhoto: movie.mainPhoto
    });
  }

  Future<void> _storeMovieStillcutList(MovieModel movie) async{
    debugPrint('로컬 DB에 스틸컷 저장중...');

    movie.stillcutList.forEach((stillcut) async{
      await _db.insert(tableStillcut, {
        stillcutColCode: movie.movieCode,
        stillcutColPhoto: stillcut
      });
    });
  }

  Future<void> _storeMovieActorList(MovieModel movie) async{
    debugPrint('로컬 DB에 배우 저장중...');

    movie.actorList.forEach((actor) async{
      await _db.insert(tableActor, {
        actorColCode: movie.movieCode,
        actorColLevel: actor.level,
        actorColName: actor.name,
        actorColRole: actor.role,
        actorColThumbnail: actor.thumbnail
      });
    });
  }

  Future<void> _storeMovieTrailerList(MovieModel movie) async{
    debugPrint('로컬 DB에 트레일러 저장중...');

    movie.trailerList.forEach((trailer) async{
      await _db.insert(tableTrailer, {
        trailerColCode: movie.movieCode,
        trailerColVideo: trailer,
      });
    });
  }

  Future<bool> _isLocalDBExist(MovieModel movie) async {
    debugPrint('로컬 DB 체크...');

    var result = await _db.rawQuery(
      'SELECT * FROM $tableMovie WHERE $movieColCode=${movie.movieCode}');
    
    result.isNotEmpty ? debugPrint('로컬 DB 있음!') : debugPrint('로컬 DB 없음ㅠ');
    return result.isNotEmpty;
  }

  Future<MovieModel> _getMovieFromLocalDB(MovieModel movie) async {
    debugPrint('로컬 DB에서 ${movie.title} 가져오기...');

    var movieDefault = await _db.rawQuery(
      'SELECT * FROM $tableMovie WHERE $movieColCode=${movie.movieCode}'
    );
    var movieStillcut = await _db.rawQuery(
      'SELECT * FROM $tableStillcut WHERE $stillcutColCode=${movie.movieCode}'
    );
    var movieActor = await _db.rawQuery(
      'SELECT * FROM $tableActor WHERE $actorColCode=${movie.movieCode}'
    );
    var movieTrailer = await _db.rawQuery(
      'SELECT * FROM $tableTrailer WHERE $trailerColCode=${movie.movieCode}'
    );

    return MovieModel.fromLocalDB(
      movieDefault: movieDefault[0],
      movieStillcutList: movieStillcut,
      movieActorList: movieActor,
      movieTrailerList: movieTrailer
    );
  }

  Future<void> _stroeIntoLocalDB(MovieModel movie) async {
    await _storeMovieDefaultInfo(movie);
    await _storeMovieActorList(movie);
    await _storeMovieStillcutList(movie);
    await _storeMovieTrailerList(movie);
  }

  Future<MovieModel> getMoreInfoOfMovie(MovieModel movie) async {
    debugPrint("영화의 총체적인 정보 가져오는 중...");

    await _dbInitialization();
    if(await _isLocalDBExist(movie)) {
      return await _getMovieFromLocalDB(movie);
    }

    http.Response mainPageResponse = await http.get(movie.link);
    http.Response realPhotoPageResponse = await http.get(movieRealPhotoUrl+movie.movieCode);
    http.Response subPhotosResponse = await http.get(movieSubPhotosUrl+movie.movieCode+'#tab');
    http.Response actorResponse = await http.get(movieActorUrl+movie.movieCode);

    movie.description = _getMovieDescription(mainPageResponse);
    movie.mainPhoto = _getMainPhoto(realPhotoPageResponse);
    movie.stillcutList = _getStillcutList(subPhotosResponse);
    movie.actorList = _getActorList(actorResponse);
    movie.trailerList = _getMovieTrailerList(mainPageResponse);

    await _stroeIntoLocalDB(movie);

    return movie;
  }

  String _getMovieDescription(http.Response response) {
    debugPrint("영화 줄거리 가져오는 중...");

    Document document = parser.parse(response.body);
    var description = document.getElementsByClassName(movieDescriptionClass);
    return description.isNotEmpty ? description[0].text.replaceAll(RegExp(r"\s\s+"), ' ') : '';
  }

  List<String> _getMovieTrailerList(http.Response response) {
    debugPrint("영화 예고편 링크 가져오는 중...");

    Document document = parser.parse(response.body);
    var trailer = document.getElementsByClassName(movieTrailerClass);
    if(trailer.isEmpty) return [];

    List<Element> linkElement = trailer[0].getElementsByTagName(aTag);
    List<String> trailerLinkList = List<String>();
    linkElement.forEach((e) => trailerLinkList.add(movieBasicUrl+e.attributes[hrefAttributes]));
    return trailerLinkList;
  }

  String _getMainPhoto(http.Response response) {
    debugPrint("영화 포스터 가져오는 중...");

    Document document = parser.parse(response.body);
    var image = document.getElementsByTagName(imgTag);
    return image.isNotEmpty ? image[0].attributes[srcAttributes]: '';
  }

  List<String> _getStillcutList(http.Response response) {
    debugPrint("영화 스틸컷 가져오는 중...");

    Document document = parser.parse(response.body);
    List<Element> subPhotoElements = document.getElementsByClassName(movieSubPhotosClass);
    List<String> subImages = [];
    subPhotoElements[0].getElementsByTagName(imgTag).forEach((element){
      subImages.add(element.attributes[srcAttributes].split('?')[0]);
    });
    return subImages;
  }

  List<ActorModel> _getActorList(http.Response response) {
    debugPrint("영화배우 가져오는 중...");

    Document document = parser.parse(response.body);
    List<Element> actorElements = document.getElementsByClassName(movieActorAreaClass)[0].children;
    List<ActorModel> actors = List<ActorModel>();
    for(Element actorElement in actorElements) {
      actors.add(ActorModel.fromElement(actorElement));
    }
    return actors;
  }

  Future<List<MovieModel>> getMovieList({String movieTitle}) async {
    debugPrint("영화목록 가져오는 중...");

    if(movieTitle.isNotEmpty) {
      var queryParams = {'query':movieTitle };
      var uri = Uri.https(naverMovieHosthUrl,naverMovieAPIUrl,queryParams);

      http.Response response = await http.get(uri, headers: {
        naverAPIIDPart : naverAPIClientID,
        naverAPISecretPart : naverAPIClientSecret
      });

      Map jsonData = json.decode(response.body);
      List<MovieModel> movieList = List<MovieModel>();
      for(Map movieData in jsonData['items']) {
        MovieModel movie = MovieModel.fromJson(movieData);
        movieList.add(movie);
      }
      return movieList;
    }
    return [];
  }
}