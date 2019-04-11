import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/widgets/custom_progress_indicator.dart';

class MovieMainPhoto extends StatelessWidget {

  final MovieModel movie;

  const MovieMainPhoto({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: movie.movieCode,
          child: CachedNetworkImage(
            imageUrl: movie.realPhoto,
            placeholder: (_,__) => Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
              child: CustomProgressIndicator(color: Colors.white)
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.9,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.7),
                Colors.black,
              ]
            )
          ),
        )
      ]
    );
  }
}