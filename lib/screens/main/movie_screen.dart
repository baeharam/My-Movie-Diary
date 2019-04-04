import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/sub/movie_actor_list.dart';
import 'package:mymovie/screens/sub/movie_main_photo.dart';
import 'package:mymovie/screens/sub/movie_stillcut_list.dart';
import 'package:mymovie/screens/sub/movie_user_rating.dart';
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
          height: MediaQuery.of(context).size.height*2.5,
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
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MovieMoreDescription(description: widget.movie.description)
                )),
                child: Container(
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
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              WhiteLine(),
              SizedBox(height: 20.0),
              MovieSectionTitle(title: stringMovieActor),
              MovieActorList(actors: widget.movie.actors),
              SizedBox(height: 20.0),
              WhiteLine(),
              SizedBox(height: 20.0),
              MovieSectionTitle(title: stringMovieStillCut),
              MovieStillCutList(movie: widget.movie)
            ],
          ),
        ),
      ),
    );
  }
}

class MovieMoreDescription extends StatelessWidget {

  final String description;

  const MovieMoreDescription({Key key, @required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,bottom: 50.0),
          alignment: Alignment.center,
          color: Colors.black,
          child: Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              height: 1.5
            ),
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