import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/diary_list/diary_list.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/sub/diary_detail.dart';
import 'package:mymovie/screens/sub/diary_photo.dart';
import 'package:mymovie/utils/service_locator.dart';

class DiaryListFrame extends StatefulWidget {
  @override
  _DiaryListFrameState createState() => _DiaryListFrameState();
}

class _DiaryListFrameState extends State<DiaryListFrame> {

  PageController _pageController; 
  int _currentPage;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl.get<DiaryListBloc>(),
      builder: (context, state){
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
                  itemBuilder: (context,index) {
                    return Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white54, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      color: AppColor.blueGreyDark.withOpacity(0.8),
                      child: ListView(
                        children: <Widget>[
                          DiaryPhoto(index: index),
                          DiaryDetail(index: _currentPage)
                        ],
                      ),
                    );
                  },
                  controller: _pageController,
                  pageSnapping: true,
                  itemCount: sl.get<CurrentUser>().diaryLength,
                  onPageChanged: (page) 
                    => sl.get<DiaryListBloc>().dispatch(DiaryListEventSnapPage(pageIndex: page)),
                  physics: BouncingScrollPhysics(),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        );
      }
    );
  }
}