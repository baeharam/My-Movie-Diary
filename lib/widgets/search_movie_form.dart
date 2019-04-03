import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/logics/search/search.dart';
import 'package:mymovie/models/movie_model.dart';

class SearchMovieForm extends StatelessWidget {

  final MovieModel movie;
  final SearchBloc searchBloc;

  const SearchMovieForm({
    Key key,
    @required this.movie,
    @required this.searchBloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => searchBloc.dispatch(SearchEventMovieClick(movie: movie)),
      child: Material(
        elevation: 5.0,
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width*0.7,
              height: 150,
            ),
            Positioned(
              left: 10.0,
              child: movie.thumbnail.isNotEmpty 
                ? Hero(
                    tag: movie.movieCode,
                    child: CachedNetworkImage(
                    imageUrl: movie.thumbnail,
                    placeholder: (_,__) {
                      return Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      );
                    },
                    errorWidget: (_,__,___) => Container(child:Icon(Icons.error)),
                  )
                )
                : Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('이미지 없음')
                ),
            ),
            Positioned(
              right: 0.0,
              height: 150.0,
              width: MediaQuery.of(context).size.width*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    movie.director,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    movie.actor,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    movie.pubDate,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}