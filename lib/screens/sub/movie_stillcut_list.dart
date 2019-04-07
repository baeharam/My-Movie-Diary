import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/widgets/custom_progress_indicator.dart';

class MovieStillCutList extends StatelessWidget {
  /// [영화의 스틸컷 제공]

  final MovieModel movie;

  const MovieStillCutList({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movie.subImages.length,
        itemBuilder: (context, index){
          return Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => MovieStillcutViewer(imageUrl: movie.subImages[index])
              )),
              child: Hero(
                tag: movie.subImages[index],
                child: CachedNetworkImage(
                  imageUrl: movie.subImages[index],
                  placeholder: (_,__) => Container(
                    margin: EdgeInsets.all(50.0),
                    child: CustomProgressIndicator(color: Colors.white)
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class MovieStillcutViewer extends StatelessWidget {

  final String imageUrl;

  MovieStillcutViewer({@required this.imageUrl});

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
