import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:mymovie/resources/constants.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';


/// [Isolate 계산을 위한 글로벌 정의]

class SearchAPI {

  Future<MovieModel> getMoreInfoOfMovie(MovieModel movie) async {
    debugPrint("영화의 총체적인 정보 가져오는 중...");

    http.Response mainPageResponse = await http.get(movie.link);
    http.Response realPhotoPageResponse = await http.get(movieRealPhotoUrl+movie.movieCode);
    http.Response subPhotosResponse = await http.get(movieSubPhotosUrl+movie.movieCode+'#tab');
    http.Response actorResponse = await http.get(movieActorUrl+movie.movieCode);

    movie.description = _getMovieDescription(mainPageResponse);
    movie.realPhoto = _getRealPhoto(realPhotoPageResponse);
    movie.subImages = _getSubPhotos(subPhotosResponse);
    movie.actors = _getActors(actorResponse);
    movie.tailerList = _getMovieTrailerLinkList(mainPageResponse);

    return movie;
  }

  String _getMovieDescription(http.Response response) {
    debugPrint("영화 줄거리 가져오는 중...");

    Document document = parser.parse(response.body);
    var description = document.getElementsByClassName(movieDescriptionClass);
    return description.isNotEmpty ? description[0].text.replaceAll(RegExp(r"\s\s+"), ' ') : '';
  }

  List<String> _getMovieTrailerLinkList(http.Response response) {
    debugPrint("영화 예고편 링크 가져오는 중...");

    Document document = parser.parse(response.body);
    var trailer = document.getElementsByClassName(movieTrailerClass);
    if(trailer.isEmpty) return [];

    List<Element> linkElement = trailer[0].getElementsByTagName(aTag);
    List<String> trailerLinkList = List<String>();
    linkElement.forEach((e) => trailerLinkList.add(movieBasicUrl+e.attributes[hrefAttributes]));
    return trailerLinkList;
  }

  String _getRealPhoto(http.Response response) {
    debugPrint("영화 포스터 가져오는 중...");

    Document document = parser.parse(response.body);
    var image = document.getElementsByTagName(imgTag);
    return image.isNotEmpty ? image[0].attributes[srcAttributes]: '';
  }

  List<String> _getSubPhotos(http.Response response) {
    debugPrint("영화 스틸컷 가져오는 중...");

    Document document = parser.parse(response.body);
    List<Element> subPhotoElements = document.getElementsByClassName(movieSubPhotosClass);
    List<String> subImages = [];
    subPhotoElements[0].getElementsByTagName(imgTag).forEach((element){
      subImages.add(element.attributes[srcAttributes].split('?')[0]);
    });
    return subImages;
  }

  List<ActorModel> _getActors(http.Response response) {
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
        movieList.add(MovieModel.fromJson(movieData));
      }
      return movieList;
    }
    return [];
  }
}