import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';

class MovieScreen extends StatefulWidget {

  final MovieModel movie;

  MovieScreen({@required this.movie});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.movie.realPhoto,
            )
          ],
        ),
      ),
    );
  }
}