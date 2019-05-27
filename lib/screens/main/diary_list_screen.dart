import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymovie/logics/diary_list/diary_list.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/sub/diary_listview.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:mymovie/utils/service_locator.dart';

class DiaryListScreen extends StatefulWidget {
  @override
  _DiaryListScreenState createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryListScreen> {
  final DiaryListBloc _diaryListBloc = sl.get<DiaryListBloc>();

  @override
  void initState() {
    super.initState();
    _diaryListBloc.dispatch(DiaryListEventStateClear());
  }

  @override
  void dispose() {
    _diaryListBloc.dispatch(DiaryListEventStateClear());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<DiaryListEvent,DiaryListState>(
        bloc: _diaryListBloc,
        builder: (context, state){
          if(sl.get<CurrentUser>().isDiaryEmpty()) {
            return Container(
              color: AppColor.darkBlueDark,
              alignment: Alignment.center,
              child: Text(
                '일기를 작성해주세요.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                )
              ),
            );
          }
          if(state.isDeleteLoading) {
            return Container(
              alignment: Alignment.center,
              color: AppColor.darkBlueLight,
              child: SpinKitWave(
                color: Colors.white,
                size: 50.0,
              )
            );
          }
          if(state.isDeleteFailed){
            BlocSnackbar.show(context, '삭제에 실패했습니다.');
            _diaryListBloc.dispatch(DiaryListEventStateClear());
          }
          if(state.isDeleteSucceeded){
            BlocSnackbar.show(context, '일기가 삭제되었습니다.');
            _diaryListBloc.dispatch(DiaryListEventStateClear());
          }
          return DiaryListView();
        }
      ),
    );
  }
}