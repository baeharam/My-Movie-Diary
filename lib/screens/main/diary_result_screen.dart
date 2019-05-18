import 'package:flutter/material.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/screens/sub/movie_stillcut_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DiaryResultScreen extends StatefulWidget {

  final DiaryModel diaryModel;

  const DiaryResultScreen({Key key, @required this.diaryModel}) : super(key: key);

  @override
  _DiaryResultScreenState createState() => _DiaryResultScreenState();
}

class _DiaryResultScreenState extends State<DiaryResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diaryModel.movieTitle),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.create),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieStillCutList(
              stillcutList: widget.diaryModel.movieStillCutList,
              isAutoPlay: false
            ),
            SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmoothStarRating(
                    borderColor: Colors.black,
                    color: Colors.red,
                    rating: widget.diaryModel.diaryRating,
                    size: 40.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.diaryModel.diaryTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.diaryModel.diaryContents,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}