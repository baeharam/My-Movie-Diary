import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/search/search.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/sub/search_user_rating.dart';

class SearchMovieForm extends StatefulWidget {

  final MovieModel movie;
  final SearchBloc searchBloc;

  const SearchMovieForm({
    Key key,
    @required this.movie,
    @required this.searchBloc
  }) : super(key: key);

  @override
  _SearchMovieFormState createState() => _SearchMovieFormState();
}

class _SearchMovieFormState extends State<SearchMovieForm> {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SearchEvent,SearchState>(
      bloc: widget.searchBloc,
      builder: (context, state){
        if((state.isMovieCrawlLoading || state.isMovieCrawlSucceeded) 
          && widget.movie.movieCode==state.clickedMovieCode) {
          return Container(
            height: MediaQuery.of(context).size.height*0.28,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          );
        }
        return GestureDetector(
          onTap: () =>
            (state.isMovieCrawlLoading && state.clickedMovieCode!=widget.movie.movieCode)
            ? null 
            : widget.searchBloc.dispatch(SearchEventMovieClick(movie: widget.movie))
          ,
          child: Container(
            width: MediaQuery.of(context).size.width*0.75,
            height: MediaQuery.of(context).size.height*0.28,
            child: Card(
              color: AppColor.blueGreyLight,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white54, width: 2.0),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Row(
                children: [
                  SizedBox(width: 10.0),
                  widget.movie.thumbnail.isNotEmpty 
                  ? Hero(
                      tag: widget.movie.movieCode,
                      child: CachedNetworkImage(
                      imageUrl: widget.movie.thumbnail,
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
                  SearchMovieContents(movie: widget.movie)
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
      height: 160.0,
      width: MediaQuery.of(context).size.width*0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          Text(
            movie.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.0),
          SearchUserRating(movie: movie),
          SizedBox(height: 10.0),
          AutoSizeText(
            movie.mainDirector,
            style: TextStyle(
              color: Colors.white,
            ),
            minFontSize: 10.0,
            maxLines: 1,
          ),
          SizedBox(height: 10.0),
          AutoSizeText(
            movie.mainActor,
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 10.0,
          ),
          SizedBox(height: 10.0),
          Text(
            movie.pubDate,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}