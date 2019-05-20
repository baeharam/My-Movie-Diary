import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymovie/logics/diary_edit/diary_edit.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/screens/main/diary_edit_screen.dart';
import 'package:mymovie/screens/sub/diary_result_body.dart';
import 'package:mymovie/utils/service_locator.dart';

class DiaryResultScreen extends StatefulWidget {

  final DiaryModel diaryModel;

  const DiaryResultScreen({Key key, @required this.diaryModel}) : super(key: key);

  @override
  _DiaryResultScreenState createState() => _DiaryResultScreenState();
}

class _DiaryResultScreenState extends State<DiaryResultScreen> {

  final DiaryEditBloc _diaryEditBloc = sl.get<DiaryEditBloc>();
  int _randomIndex;

  @override
  void initState() {
    super.initState();
    _diaryEditBloc.dispatch(DiaryEditEventStateClear());
    _randomIndex = Random().nextInt(widget.diaryModel.movieStillCutList.length);
  }

  @override
  void dispose() {
    _diaryEditBloc.dispatch(DiaryEditEventStateClear());
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일기장'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () 
              => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DiaryEditScreen(
                  diary: widget.diaryModel,
                  isEditing: true,
                )
              )),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){},
          )
        ],
      ),
      body: DiaryResultBody(
        diaryModel: widget.diaryModel,
        randomIndex: _randomIndex
      ),
    );
  }
}