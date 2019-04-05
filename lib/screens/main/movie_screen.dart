import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/sub/movie_actor_list.dart';
import 'package:mymovie/screens/sub/movie_main_photo.dart';
import 'package:mymovie/screens/sub/movie_more_description.dart';
import 'package:mymovie/screens/sub/movie_stillcut_list.dart';
import 'package:mymovie/screens/sub/movie_user_rating.dart';
import 'package:mymovie/widgets/white_line.dart';
import 'package:video_player/video_player.dart';

class MovieScreen extends StatefulWidget {

  final MovieModel movie;

  const MovieScreen({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      'https://vod-naver.pstatic.net/navertv/owfs_rmc/read/navertv_'
      '2019_04_04_1611/hls/6f53cb7d-569c-11e9-a59c-246e963a49b9.m3u8?_'
      'lsu_sa_=6db5d9f491086306aedd951d6da507baee4b3538f701ef63396752ced'
      '7da37b54e2f6a4a69d5c103a04b35b20a3b8b1620fb4c412f730d496443763fc2'
      'd0e9ef18e228b55f031a23b0e368b2c5b37c8d001ef265c6e1b5e0e2f4c1a4093'
      'aadf45c57112e079932fdff9a21ab6db7da70f8876e7f8120d1f93720ccbb33391c6b'
    )..initialize().then((_){
      setState(() {});
    });
  }

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
              MovieStillCutList(movie: widget.movie),
              SizedBox(height: 20.0),
              WhiteLine(),
              SizedBox(height: 20.0),
              MovieSectionTitle(title: stringMovieTrailer),
              _videoController.value.initialized
              ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
              : Container()
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