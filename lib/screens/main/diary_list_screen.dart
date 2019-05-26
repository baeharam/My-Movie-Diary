import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymovie/logics/diary_list/diary_list.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/main/diary_edit_screen.dart';
import 'package:mymovie/utils/bloc_snackbar.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DiaryListScreen extends StatefulWidget {
  @override
  _DiaryListScreenState createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryListScreen> {
  final DiaryListBloc _diaryListBloc = sl.get<DiaryListBloc>();
  final List<String> imageCache = List<String>(sl.get<CurrentUser>().diaryLength);
  final ScrollController _scrollController = ScrollController();

  PageController _pageController; 
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _diaryListBloc.dispatch(DiaryListEventStateClear());
    _currentPage = 0;
    _pageController = PageController(
      initialPage: _currentPage,
      keepPage: false,
      viewportFraction: 0.9
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
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
          }
          if(state.isDeleteSucceeded){
            BlocSnackbar.show(context, '일기가 삭제되었습니다.');
          }
          if(state.isPageSnapped) {
            _currentPage = state.pageIndex;
          }
          return Container(
            color: AppColor.darkBlueDark,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context,index) => _diaryPhotoBuilder(index),
                    controller: _pageController,
                    pageSnapping: true,
                    itemCount: sl.get<CurrentUser>().diaryLength,
                    onPageChanged: (page) 
                      => _diaryListBloc.dispatch(DiaryListEventSnapPage(pageIndex: page)),
                    physics: ClampingScrollPhysics(),
                  ),
                ),
                _diaryDetailBuilder(_currentPage)
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _diaryDetailBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs()*0.5)).clamp(0.0, 1.0);
        }
        return Expanded(
          child: Transform.translate(
            offset: Offset(0, 200 + (-value*200)),
            child: Opacity(
              opacity: value,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white,width: 2.0)),
                        ),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.create,size: 30.0,color: Colors.white,),
                              Text(
                                '수정',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                                ),
                              )
                            ],
                          ),
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DiaryEditScreen(
                              diary: sl.get<CurrentUser>().diaryList[index],
                              isEditing: true,
                            ))),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white,width: 2.0)),
                        ),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.delete,size: 30.0,color: Colors.white,),
                              Text(
                                '삭제',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                                ),
                              )
                            ],
                          ),
                          onTap: () => 
                            _diaryListBloc.dispatch(DiaryListEventDelete(diary: 
                              sl.get<CurrentUser>().diaryList[index])),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  SmoothStarRating(
                    color: Colors.red,
                    borderColor: Colors.white,
                    size: 40.0,
                    rating: sl.get<CurrentUser>().diaryList[index].diaryRating,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    sl.get<CurrentUser>().diaryList[index].diaryTitle,
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
                      sl.get<CurrentUser>().diaryList[index].diaryContents,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ]
              ),
            ),
          )
        );
      }
    );
  }

  Widget _diaryPhotoBuilder(index) {
    if(imageCache[index]==null || index==_currentPage) {
      imageCache[index] = sl.get<CurrentUser>().diaryList[index].movieStillCutList[
        Random().nextInt(sl.get<CurrentUser>().diaryList[index].movieStillCutList.length)
      ];
    }
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs()*0.5)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: child
            ),
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: child
            ),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: AppColor.darkBlueLight,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                sl.get<CurrentUser>().diaryList[index].movieTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                    imageUrl: imageCache[index],
                    placeholder: (_,__) => SpinKitWave(
                      color: Colors.white,
                      size: 50.0,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}