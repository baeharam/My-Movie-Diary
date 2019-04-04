import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/widgets/custom_progress_indicator.dart';

class MovieActorList extends StatelessWidget {
  
  final List<ActorModel> actors;

  const MovieActorList({Key key, @required this.actors}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CachedNetworkImage(
                imageUrl: actors[index].thumbnail,
                placeholder: (_,__) => Container(
                  margin: const EdgeInsets.all(30.0),
                  child: CustomProgressIndicator(color: Colors.white),
                ),
              ),
              Text(
                actors[index].name
              )
            ]
          );
        }
      ),
    );
  }
}