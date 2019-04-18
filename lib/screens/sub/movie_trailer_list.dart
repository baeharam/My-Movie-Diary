
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:mymovie/models/movie_model.dart';

class MovieTrailerList extends StatefulWidget {

  final MovieModel movie;

  const MovieTrailerList({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieTrailerListState createState() => _MovieTrailerListState();
}

class _MovieTrailerListState extends State<MovieTrailerList> {

  PageController _trailerController;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _trailerController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _trailerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _progress<1.0 ? Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child:LinearProgressIndicator(
            value: _progress,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Colors.black,
          ) 
        )
        : Container(),
        SizedBox(height: 10.0),
        Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 400.0,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _trailerController,
            itemCount: widget.movie.trailerList.length,
            itemBuilder: (context, index){
              return InAppWebView(
                initialUrl: widget.movie.trailerList[index],
                onProgressChanged: (_,progress) => setState(()=>_progress=progress/100),
              );
            }
          ),
        ),
      ],
    );
  }
}