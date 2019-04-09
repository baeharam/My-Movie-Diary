import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:mymovie/resources/constants.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';


class SearchAPI {


  Future<List<MovieModel>> getMovieList({@required String movieTitle}) async {
    debugPrint("Call getMovieList()");

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

  Future<MovieModel> getMoreInfoOfMovie({@required MovieModel movie}) async {
    debugPrint("Call getMoreInfoOfMovie()");

    http.Response mainPageResponse = await http.get(movie.link);
    http.Response realPhotoPageResponse = await http.get(movieRealPhotoUrl+movie.movieCode);
    http.Response subPhotosResponse = await http.get(movieSubPhotosUrl+movie.movieCode+'#tab');
    http.Response actorResponse = await http.get(movieActorUrl+movie.movieCode);

    movie.description = _getMovieDescription(mainPageResponse);
    movie.realPhoto = _getRealPhoto(realPhotoPageResponse);
    movie.subImages = _getSubPhotos(subPhotosResponse);
    movie.actors = _getActors(actorResponse);
    

    return movie;
  }

  String _getMovieDescription(http.Response response) {
    debugPrint("Call _getMovieDescription()");

    Document document = parser.parse(response.body);
    var description = document.getElementsByClassName(movieDescriptionClass);
    return description.isNotEmpty ? description[0].text.replaceAll(RegExp(r"\s\s+"), ' ') : '';
  }

  String _getRealPhoto(http.Response response) {
    debugPrint("Call _getRealPhoto()");

    Document document = parser.parse(response.body);
    var image = document.getElementsByTagName(imgTag);
    return image.isNotEmpty ? image[0].attributes[srcAttributes]: '';
  }

  List<String> _getSubPhotos(http.Response response) {
    debugPrint("Call _getSubPhotos()");

    Document document = parser.parse(response.body);
    List<Element> subPhotoElements = document.getElementsByClassName(movieSubPhotosClass);
    List<String> subImages = [];
    subPhotoElements[0].getElementsByTagName(imgTag).forEach((element){
      subImages.add(element.attributes[srcAttributes].split('?')[0]);
    });
    return subImages;
  }

  List<ActorModel> _getActors(http.Response response) {
    debugPrint("Call _getActors()");

    Document document = parser.parse(response.body);
    List<Element> actorElements = document.getElementsByClassName(movieActorAreaClass)[0].children;
    List<ActorModel> actors = List<ActorModel>();
    for(Element actorElement in actorElements) {
      actors.add(ActorModel.fromElement(actorElement));
    }
    return actors;
  }
}