import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/search/search.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/screens/sub/search_movie_form.dart';

class SearchResultForm extends StatelessWidget {

  final List<MovieModel> movieList;
  final SearchBloc searchBloc;

  const SearchResultForm({
    Key key, 
    @required this.movieList,
    @required this.searchBloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchEvent,SearchState>(
        bloc: searchBloc,
        builder: (context, state){
          if(state.isMovieAPICallLoading) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                '영화를 찾고 있습니다...',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
                ),
              )
            );
          }
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: movieList.length,
            itemBuilder: (_, index) {
              if(state.isMovieCrawlLoading && 
                movieList[index].movieCode==state.clickedMovieCode) {
                return Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(30.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                );
              }
              return Column(
                children: <Widget>[
                  SearchMovieForm(
                    movie: movieList[index],
                    searchBloc: searchBloc,
                  ),
                  SizedBox(height: 30.0)
                ],
              );
            }
          );
        }
      )
    );
  }
}
