import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/search/search.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/screens/sub/search_user_rating.dart';

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

    return BlocBuilder<SearchEvent,SearchState>(
      bloc: searchBloc,
      builder: (context, state){
        if(state.isMovieCrawlLoading && 
          movie.movieCode==state.clickedMovieCode) {
          return Container(
            height: 100.0,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(30.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          );
        }
        return GestureDetector(
          onTap: () =>
            (state.isMovieCrawlLoading && state.clickedMovieCode!=movie.movieCode)
            ? null 
            : searchBloc.dispatch(SearchEventMovieClick(movie: movie))
          ,
          child: Container(
            width: MediaQuery.of(context).size.width*0.75,
            height: MediaQuery.of(context).size.height*0.28,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                children: [
                  SizedBox(width: 10.0),
                  movie.thumbnail.isNotEmpty 
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
                  SizedBox(width: 10.0),
                  SearchMovieContents(movie: movie)
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class SearchMovieContents extends StatelessWidget {

  final MovieModel movie;

  const SearchMovieContents({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SearchUserRating(movie: movie),
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
      ),
    );
  }
}