import 'package:mymovie/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:mymovie/resources/constants.dart';
import 'package:rxdart/rxdart.dart';


class SearchAPI {

  Observable<List<MovieModel>> movieStream;


  Future<void> getMovieInfo(String movieTitle) async {
    var queryParams = {'query':movieTitle };
    var uri = Uri.https(naverMovieSearchUrl,'/',queryParams);

    http.Response response = await http.get(uri);
    print(response.body);
  }
}