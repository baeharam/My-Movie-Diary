import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/diary_edit/diary_edit.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/sub/diary_edit_frame.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DiaryEditScreen extends StatefulWidget {

  final DiaryModel diary;
  final bool isEditing;

  const DiaryEditScreen({Key key, @required this.diary, @required this.isEditing}): super(key: key);

  @override
  _DiaryEditScreenState createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends State<DiaryEditScreen> {

  @override
  void initState() {
    super.initState();
    sl.get<DiaryEditBloc>().dispatch(DiaryEditEventStateClear());
  }

  @override
  void dispose() {
    sl.get<DiaryEditBloc>().dispatch(DiaryEditEventStateClear());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<DiaryEditEvent,DiaryEditState>(
          bloc: sl.get<DiaryEditBloc>(),
          builder: (context, state){ 
            if(state.isDiaryCompleteSucceeded) {
              BlocNavigator.pushNamed(context, routeDiaryList);
            }
            if(state.isDiaryUpdateSucceeded) {
              BlocNavigator.pop(context);
            }
            if(state.isDiaryCompleteLoading || state.isDiaryCompleteSucceeded
            || state.isDiaryUpdateLoading || state.isDiaryUpdateSucceeded){
              return SpinKitWave(
                color: Colors.white,
                size: 50.0,
              );
            }
            if(state.isDiaryCompleteFailed) {
              BlocSnackbar.show(context,'일기를 저장하는데 실패했습니다.');
            }
            if(state.isDiaryUpdateFailed) {
              BlocSnackbar.show(context,'일기를 수정하는데 실패했습니다.');
            }
            return DiaryEditFrame(diary: widget.diary,isEditing: widget.isEditing);
          }
        )
      )
    );
  }
}

class DiaryCompleteButton extends StatelessWidget {

  final DiaryModel diaryModel;
  final bool isEditing;


  const DiaryCompleteButton({
    Key key, 
    @required this.diaryModel,
    @required this.isEditing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(Icons.check,color: Colors.white,size: 50.0),
      ),
      onTap: () => 
      isEditing 
      ? sl.get<DiaryEditBloc>().dispatch(DiaryEditEventUpdate(diaryModel: diaryModel))
      : sl.get<DiaryEditBloc>().dispatch(DiaryEditEventComplete(diaryModel: diaryModel)),
    );
  }
}