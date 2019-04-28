import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/search/search.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/screens/sub/search_movie_form.dart';

class SearchResultForm extends StatefulWidget {

  final List<MovieModel> movieList;
  final SearchBloc searchBloc;
  final TextEditingController searchBarController;

  const SearchResultForm({
    Key key, 
    @required this.movieList,
    @required this.searchBloc,
    @required this.searchBarController
  }) : super(key: key);

  @override
  _SearchResultFormState createState() => _SearchResultFormState();
}

class _SearchResultFormState extends State<SearchResultForm> {

  final FixedExtentScrollController _controller = FixedExtentScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SearchEvent,SearchState>(
      bloc: widget.searchBloc,
      builder: (context,state){
        if((state.isKeyboardOn&&widget.movieList.isEmpty) || widget.searchBarController.text.isEmpty){
          return SearchProcessingMessage(message: '영화를 검색해주세요.');
        }
        if(state.isMovieAPICallLoading) {
          return SearchProcessingMessage(message: '영화를 찾고 있습니다...');
        }
        if(state.isMovieAPICallSucceeded && widget.movieList.isEmpty) {
          return SearchProcessingMessage(message: '찾으시는 영화가 없습니다.');
        }
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.movieList.length,
            itemBuilder: (_, index) {
              return Column(
                children: <Widget>[
                  SearchMovieForm(
                    movie: widget.movieList[index],
                    searchBloc: widget.searchBloc,
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
          fontSize: 20.0
        ),
      )
    );
  }
}
