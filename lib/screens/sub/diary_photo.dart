import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/utils/service_locator.dart';

class DiaryPhoto extends StatelessWidget {

  final int index;

  const DiaryPhoto({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          sl.get<CurrentUser>().diaryList[index].movieTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0
          ),
        ),
        SizedBox(height: 20.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: CarouselSlider(
            autoPlayInterval: const Duration(milliseconds: 3000),
            enlargeCenterPage: true,
            items: sl.get<CurrentUser>().diaryList[index].movieStillCutList.map((imageUrl){
              return Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (_,__) => Container(
                    margin: EdgeInsets.all(50.0),
                    child: SpinKitWave(
                      color: Colors.white,
                      size: 50.0,
                    )
                  ),
                ),
              );}
            ).toList()
          ),
        ),
      ],
    );
  }
}