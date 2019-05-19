import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymovie/logics/diary_edit/diary_edit.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/screens/sub/diary_result_body.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){},
          )
        ],
      ),
      body: BlocBuilder(
        bloc: sl.get<DiaryEditBloc>(),
        builder: (context, state){
          if(state.isDiaryCompleteSucceeded) {
            BlocNavigator.pop(context);
          }
          if(state.isDiaryCompleteLoading || state.isDiaryCompleteSucceeded){
            return SpinKitWave(
              color: Colors.white,
              size: 50.0,
            );
          }
          if(state.isDiaryCompleteFailed) {
            BlocSnackbar.show(context,'일기를 저장하는데 실패했습니다.');
          }

          return DiaryResultBody(
            diaryModel: widget.diaryModel,
            randomIndex: _randomIndex
          );
        }
      ),
    );
  }
}