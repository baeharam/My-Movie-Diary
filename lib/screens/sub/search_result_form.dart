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

    return BlocBuilder<SearchEvent,SearchState>(
      bloc: searchBloc,
      builder: (context,state){
        if(state.isMovieAPICallLoading) {
          return SearchProcessingMessage(message: '영화를 찾고 있습니다...');
        }
        if(state.isMovieAPICallSucceeded && movieList.isEmpty) {
          return SearchProcessingMessage(message: '찾으시는 영화가 없습니다.');
        }
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: movieList.length,
            itemBuilder: (_, index) {
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
          ),
        );
      }
    );
  }
}

class SearchProcessingMessage extends StatelessWidget {

  final String message;

  const SearchProcessingMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 100.0),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      )
    );
  }
}
