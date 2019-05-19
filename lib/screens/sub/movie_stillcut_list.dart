import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/widgets/custom_progress_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieStillCutList extends StatelessWidget {

  final List<String> stillcutList;
  final bool isAutoPlay;

  const MovieStillCutList({
    Key key, 
    @required this.stillcutList, 
    this.isAutoPlay: true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.35,
      child: CarouselSlider(
        autoPlay: isAutoPlay,
        autoPlayInterval: const Duration(milliseconds: 3000),
        enlargeCenterPage: true,
        items: stillcutList.map((imageUrl){
          return Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => MovieStillcutViewer(imageUrl: imageUrl)
              )),
              child: Hero(
                tag: imageUrl,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (_,__) => Container(
                    margin: EdgeInsets.all(50.0),
                    child: CustomProgressIndicator(color: Colors.white)
                  ),
                ),
              ),
            ),
          );}
        ).toList()
      ),
    );
  }
}

class MovieStillcutViewer extends StatelessWidget {

  final String imageUrl;

  const MovieStillcutViewer({Key key, this.imageUrl}) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
}
