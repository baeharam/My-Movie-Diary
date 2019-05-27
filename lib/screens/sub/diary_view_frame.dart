import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/main/diary_edit_screen.dart';
import 'package:mymovie/screens/sub/diary_detail.dart';
import 'package:mymovie/screens/sub/diary_photo.dart';

class DiaryViewFrame extends StatefulWidget {

  final DiaryModel diary;

  const DiaryViewFrame({Key key, @required this.diary}) : super(key: key);

  @override
  _DiaryViewFrameState createState() => _DiaryViewFrameState();
}

class _DiaryViewFrameState extends State<DiaryViewFrame> {

  String randomImage = "";

  @override
  void initState() {
    super.initState();
    randomImage = widget.diary.movieStillCutList[Random().nextInt(widget.diary.movieStillCutList.length)];
  }

  @override
  void dispose() {
    randomImage = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DiaryEditScreen(
            diary: widget.diary,
            isEditing: true
          )
        )),
        icon: Icon(Icons.edit),
        label: Text('수정하기'),
        heroTag: 'diary',
        backgroundColor: AppColor.darkBlueWhite,
      ),
      body: Hero(
        tag: widget.diary.movieCode,
        child: Container(
          color: AppColor.darkBlueDark,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Expanded(
                child: Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white54, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  color: AppColor.blueGreyDark.withOpacity(0.8),
                  child: ListView(
                    children: <Widget>[
                      DiaryPhoto(
                        title: widget.diary.movieTitle,
                        photo: randomImage,
                      ),
                      DiaryDetail(diary: widget.diary)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}