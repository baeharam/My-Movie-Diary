import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/widgets/custom_progress_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MovieActorList extends StatelessWidget {
  /// [배우 리스트 제공]
  
  final List<ActorModel> actors;

  const MovieActorList({Key key, @required this.actors}) : super(key: key);

  
  // TODO: 배우 디자인 수정..
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemBuilder: (context, index) {
          return Container(
            height: 250.0,
            width: 111.0,
            margin: const EdgeInsets.only(right: 20.0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: actors[index].thumbnail,
                  placeholder: (_,__) => Container(
                    margin: const EdgeInsets.all(30.0),
                    child: CustomProgressIndicator(color: Colors.black),
                  ),
                ),
                Container(
                  height: 61.0,
                  width: 111.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      AutoSizeText(
                        actors[index].name,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 10.0),
                      AutoSizeText(
                        actors[index].role,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        minFontSize: 10.0,
                        overflow: TextOverflow.ellipsis,
                      )                      
                    ],
                  )
                ),
              ]
            ),
          );
        }
      ),
    );
  }
}