import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymovie/logics/diary_list/diary_list.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/sub/diary_view_frame.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/widgets/modal_progress.dart';

class DiaryListView extends StatefulWidget {
  @override
  _DiaryListViewState createState() => _DiaryListViewState();
}

class _DiaryListViewState extends State<DiaryListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.darkBlueDark,
      child: ListView.builder(
        itemCount: sl.get<CurrentUser>().diaryLength,
        itemBuilder: (context, index){
          return BlocBuilder<DiaryListEvent,DiaryListState>(
            bloc: sl.get<DiaryListBloc>(),
            builder: (context, state) {
              return Stack(
                children: <Widget>[
                  Dismissible(
                    key: Key(sl.get<CurrentUser>().diaryList[index].movieCode),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => DiaryViewFrame(diary: sl.get<CurrentUser>().diaryList[index])
                      )),
                      child: Hero(
                        tag: sl.get<CurrentUser>().diaryList[index].movieCode,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: DiaryCardItem(index: index),
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) => sl.get<DiaryListBloc>().dispatch(DiaryListEventDelete(diary: 
                            sl.get<CurrentUser>().diaryList[index])),
                  ),
                  state.isDeleteLoading
                  ? ModalProgress(text: '일기를 삭제중입니다...')
                  : Container()
                ],
              );
            }
          );
        }
      ),
    );
  }
}

class DiaryCardItem extends StatelessWidget {

  final int index;

  const DiaryCardItem({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.blueGreyDark,
      shape: Border.all(color: Colors.white.withOpacity(0.8), width: 2.0,),
      elevation: 4.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              child: CachedNetworkImage(
                imageUrl: sl.get<CurrentUser>().diaryList[index].movieMainPhoto,
                placeholder: (_,__) => SpinKitWave(color: Colors.white,size: 50.0),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  sl.get<CurrentUser>().diaryList[index].movieTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: 150.0,
                  height: 100.0,
                  child: Text(
                    sl.get<CurrentUser>().diaryList[index].diaryContents,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}