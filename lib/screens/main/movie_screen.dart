import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/sub/movie_actor_list.dart';
import 'package:mymovie/screens/sub/movie_description.dart';
import 'package:mymovie/screens/sub/movie_main_photo.dart';
import 'package:mymovie/screens/sub/movie_stillcut_list.dart';
import 'package:mymovie/screens/sub/movie_trailer_list.dart';
import 'package:mymovie/screens/sub/movie_user_rating.dart';
import 'package:mymovie/utils/orientation_fixer.dart';
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
    OrientationFixer.fixPortrait();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
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
              MovieUserRating(movie: widget.movie),
              SizedBox(height: 20.0),
              WhiteLine(),
              MovieSectionTitle(title: stringMovieSynopsis),
              MovieDescription(description: widget.movie.description),
              SizedBox(height: 20.0),
              WhiteLine(),
              SizedBox(height: 20.0),
              MovieSectionTitle(title: stringMovieActor),
              MovieActorList(actors: widget.movie.actors),
              SizedBox(height: 20.0),
              WhiteLine(),
              SizedBox(height: 20.0),
              MovieSectionTitle(title: stringMovieStillCut),
              MovieStillCutList(movie: widget.movie),
              SizedBox(height: 20.0),
              WhiteLine(),
              SizedBox(height: 20.0),
              MovieSectionTitle(title: stringMovieTrailer),
              MovieTrailerList(movie: widget.movie)
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
      child: AutoSizeText(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        minFontSize: 25.0,
      ),
    );
  }
}