import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/sub/movie_actor_list.dart';
import 'package:mymovie/screens/sub/movie_main_photo.dart';
import 'package:mymovie/screens/sub/movie_stillcut_list.dart';
import 'package:mymovie/widgets/white_line.dart';

class MovieScreen extends StatefulWidget {

  final MovieModel movie;

  const MovieScreen({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height*3,
          child: Column(
            children: [
              MovieMainPhoto(movie: widget.movie),
              MovieSectionTitle(title: widget.movie.title),
              Container(
                color: Colors.black,
                child: Text(
                  '('+widget.movie.pubDate+')',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              WhiteLine(),
              MovieSectionTitle(title: movieScreenSynopsis),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.black,
                child: Text(
                  widget.movie.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    height: 1.3
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              WhiteLine(),
              SizedBox(height: 20.0),
              MovieSectionTitle(title: movieScreenActor),
              MovieActorList(actors: widget.movie.actors),
              SizedBox(height: 20.0),
              WhiteLine(),
              SizedBox(height: 20.0),
              MovieSectionTitle(title: movieScreenPhoto),
              MovieStillCutList(movie: widget.movie)
            ],
          ),
        ),
      ),
    );
  }
}

class MovieSectionTitle extends StatelessWidget {

  final String title;
  const MovieSectionTitle({Key key, @required this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),
      ),
    );
  }
}