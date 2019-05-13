import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/diary/diary.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/screens/sub/diary_frame.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DiaryScreen extends StatefulWidget {

  final MovieModel movie;

  const DiaryScreen({Key key, @required this.movie}) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {

  @override
  void initState() {
    super.initState();
    sl.get<DiaryBloc>().dispatch(DiaryEventStateClear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<DiaryEvent,DiaryState>(
          bloc: sl.get<DiaryBloc>(),
          builder: (context, state){ 
            if(state.isDiaryCompleteLoading) {
              return SpinKitWave(
                color: Colors.white,
                size: 50.0,
              );
            }
            if(state.isDiaryCompleteFailed) {
              BlocSnackbar.show(context,'일기를 저장하는데 실패했습니다.');
            }
            return DiaryFrame(movie: widget.movie);
          }
        )
      )
    );
  }
}

class DiaryCompleteButton extends StatelessWidget {

  final DiaryModel diaryModel;

  const DiaryCompleteButton({Key key, @required this.diaryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(Icons.check,color: Colors.white,size: 50.0),
      ),
      onTap: () => sl.get<DiaryBloc>().dispatch(DiaryEventComplete(diaryModel: diaryModel)),
    );
  }
}