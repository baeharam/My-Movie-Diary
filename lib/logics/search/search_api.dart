import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:mymovie/resources/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';


class SearchAPI {

  Future<List<MovieModel>> getMovieList({@required String movieTitle}) async {
    if(movieTitle.isNotEmpty) {
      var queryParams = {'query':movieTitle };
      var uri = Uri.https(naverMovieHosthUrl,naverMovieAPIUrl,queryParams);

      http.Response response = await http.get(uri, headers: {
        'X-Naver-Client-Id':naverAPIClientID,
        'X-Naver-Client-Secret':naverAPIClientSecret
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


  // Future<void> getMovieInfo(String movieTitle) async {
  //   String moviePageUrl = jsonData['items'][1]['link'];


  //   http.Response response2 = await http.get(moviePageUrl);
  //   Document parsingHtml = parser.parse(response2.body);
  //   var description =parsingHtml.getElementsByClassName('con_tx');
  //   print(description[0].text);
  // }
}