import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/widgets/custom_progress_indicator.dart';

class MovieStillCutList extends StatefulWidget {
  /// [영화의 스틸컷 제공]

  final MovieModel movie;

  const MovieStillCutList({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieStillCutListState createState() => _MovieStillCutListState();
}

class _MovieStillCutListState extends State<MovieStillCutList> {

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.35,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemCount: widget.movie.subImages.length,
        itemBuilder: (context, index){
          return Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => MovieStillcutViewer(
                  movie: widget.movie,
                  currentIndex: index,
                  originalController: _pageController)
              )),
              child: Hero(
                tag: widget.movie.subImages[index],
                child: CachedNetworkImage(
                  imageUrl: widget.movie.subImages[index],
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

class MovieStillcutViewer extends StatefulWidget {

  final MovieModel movie;
  final int currentIndex;
  final PageController originalController;


  const MovieStillcutViewer({
    Key key, 
    @required this.movie, 
    @required this.currentIndex,
    @required this.originalController
  }) : assert(movie!=null),
       assert(currentIndex!=null),
       assert(originalController!=null),
       super(key: key);

  @override
  _MovieStillcutViewerState createState() => _MovieStillcutViewerState();
}

class _MovieStillcutViewerState extends State<MovieStillcutViewer> {
  
  PageController _pageController;

  Widget _buildPhotoPage(String imageUrl) {
    return Container(
      alignment: Alignment.center,
      child: Hero(
        tag: imageUrl,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (_,__) {
            return Container(
              child: CustomProgressIndicator(color: Colors.white)
            );
          }
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: List.generate(widget.movie.subImages.length, 
        (index)=>_buildPhotoPage(widget.movie.subImages[index])),
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (page) => widget.originalController.jumpToPage(page)
    );
  }
}
