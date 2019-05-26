import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/main/diary_edit_screen.dart';
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
      body: Container(
        color: Colors.black,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height*0.8,
              flexibleSpace: FlexibleSpaceBar(
                background: MovieMainPhoto(movie: widget.movie),
              ),
              backgroundColor: Colors.black,
              leading: Container(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MovieSectionTitle(title: widget.movie.title),
                      Container(
                        color: Colors.black,
                        child: Text(
                          '('+widget.movie.pubDate+')',
                          style: TextStyle(
                            color: Colors.white,
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
                      MovieActorList(actors: widget.movie.actorList),
                      SizedBox(height: 20.0),
                      WhiteLine(),
                      SizedBox(height: 20.0),
                      MovieSectionTitle(title: stringMovieStillCut),
                      MovieStillCutList(stillcutList: widget.movie.stillcutList),
                      SizedBox(height: 20.0),
                      WhiteLine(),
                      SizedBox(height: 20.0),
                      MovieSectionTitle(title: stringMovieTrailer),
                      MovieTrailerList(movie: widget.movie)
                    ]
                  )
                ]
              ),
            )
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DiaryEditScreen(diary: DiaryModel.make(
            movieCode: widget.movie.movieCode,
            moviePubDate: widget.movie.pubDate,
            movieMainPhoto: widget.movie.mainPhoto,
            movieTitle: widget.movie.title,
            movieStillCutList: widget.movie.stillcutList,
            movieLineList: widget.movie.lineList
          ),isEditing: false)
        )),
        icon: Icon(Icons.edit),
        label: Text('일기쓰기'),
        heroTag: 'diary',
        backgroundColor: Color(0xff333435),
      )
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
        ),
        maxLines: 1,
        minFontSize: 25.0,
      ),
    );
  }
}