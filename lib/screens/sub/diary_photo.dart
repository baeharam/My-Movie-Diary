import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DiaryPhoto extends StatelessWidget {

  final String title;
  final String photo;

  const DiaryPhoto({Key key, @required this.title,@required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0
          ),
        ),
        SizedBox(height: 20.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: CachedNetworkImage(
            imageUrl: photo,
            placeholder: (_,__) {
              return Container(
                alignment: Alignment.center,
                child: SpinKitWave(
                  color: Colors.white,
                  size: 50.0
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}