import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/logics/search/search.dart';

class SearchBar extends StatelessWidget {

  final TextEditingController searchBarController;
  final SearchBloc searchBloc;

  const SearchBar({
    Key key, 
    @required this.searchBarController, 
    @required this.searchBloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.white),
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        child: TextField(
          decoration: InputDecoration(
            labelText: '영화',
            labelStyle: Theme.of(context).textTheme
              .caption.copyWith(color: Colors.white),
          ),
          controller: searchBarController,
          autofocus: false,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          onChanged: (text) {
            searchBloc.dispatch(SearchEventTextChanged(text: text));
          },
        ),
      ),
    );
  }
}