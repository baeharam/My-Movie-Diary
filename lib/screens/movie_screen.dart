import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/widgets/custom_progress_indicator.dart';
import 'package:mymovie/widgets/white_line.dart';

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
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height*3,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: widget.movie.movieCode,
                    child: CachedNetworkImage(
                      imageUrl: widget.movie.realPhoto,
                      placeholder: (_,__) => CustomProgressIndicator(color: Colors.white),
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
                          Colors.black
                        ]
                      )
                    ),
                  )
                ]
              ),
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
              MovieSectionTitle(title: movieScreenPhoto),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movie.subImages.length,
                  itemBuilder: (context, index){
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MoviePhotoViewer(imageUrl: widget.movie.subImages[index])
                        )),
                        child: Hero(
                          tag: widget.movie.subImages[index],
                          child: CachedNetworkImage(
                            imageUrl: widget.movie.subImages[index],
                            placeholder: (_,__) => Container(
                              margin: EdgeInsets.all(50.0),
                              child: CustomProgressIndicator(color: Colors.white)
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MoviePhotoViewer extends StatelessWidget {

  final String imageUrl;

  MoviePhotoViewer({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Hero(
        tag: imageUrl,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}

class MovieSectionTitle extends StatelessWidget {

  final String title;
  MovieSectionTitle({@required this.title});

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