import 'package:flutter/material.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DiaryDetail extends StatelessWidget {

  final DiaryModel diary;

  const DiaryDetail({Key key, @required this.diary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.0),
        SmoothStarRating(
          color: Colors.red,
          borderColor: Colors.white,
          size: 40.0,
          rating: diary.diaryRating,
        ),
        SizedBox(height: 20.0),
        Text(
          diary.diaryTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        SizedBox(height: 20.0,),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: Text(
            diary.diaryContents,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ]
    );
  }
}