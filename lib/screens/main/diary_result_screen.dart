import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymovie/logics/diary_edit/diary_edit.dart';
import 'package:mymovie/logics/diary_result/diary_result.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/main/diary_edit_screen.dart';
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
  final DiaryResultBloc _diaryResultbloc = sl.get<DiaryResultBloc>();
  int _randomIndex;

  @override
  void initState() {
    super.initState();
    _diaryEditBloc.dispatch(DiaryEditEventStateClear());
    _diaryResultbloc.dispatch(DiaryResultEventStateClear());
    _randomIndex = Random().nextInt(widget.diaryModel.movieStillCutList.length);
  }

  @override
  void dispose() {
    _diaryEditBloc.dispatch(DiaryEditEventStateClear());
    _diaryResultbloc.dispatch(DiaryResultEventStateClear());
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
            onPressed: () => _diaryResultbloc.dispatch(DiaryResultEventDelete(diary: widget.diaryModel)),
          )
        ],
      ),
      body: BlocBuilder<DiaryResultEvent, DiaryResultState>(
        bloc: _diaryResultbloc,
        builder: (context, state){
          if(state.isDeleteLoading) {
            return Container(
              alignment: Alignment.center,
              decoration: AppColor.diaryResultGradient,
              child: SpinKitWave(
                color: Colors.white,
                size: 50.0,
              )
            );
          }
          if(state.isDeleteFailed){
            BlocSnackbar.show(context, '삭제에 실패했습니다.');
          }
          if(state.isDeleteSucceeded){
            BlocSnackbar.show(context, '일기가 삭제되었습니다.');
            BlocNavigator.pop(context);
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