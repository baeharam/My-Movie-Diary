import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/diary_list/diary_list.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DiaryListScreen extends StatefulWidget {
  @override
  _DiaryListScreenState createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryListScreen> {

  final List<DiaryModel> _diaryList = sl.get<CurrentUser>().diary;
  final DiaryListBloc _diaryListBloc = sl.get<DiaryListBloc>();

  PageController _pageController; 
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      keepPage: false,
      viewportFraction: 0.8
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DiaryListEvent,DiaryListState>(
        bloc: _diaryListBloc,
        builder: (context, state){
          if(state.isPageSnapped) {
            _currentPage = state.pageIndex;
          }
          return Column(
            children: <Widget>[
              Container(
                height: 600.0,
                child: PageView.builder(
                  itemBuilder: (context,index) => _diaryPhotoBuilder(index),
                  controller: _pageController,
                  pageSnapping: true,
                  itemCount: _diaryList.length,
                  onPageChanged: (page) => _diaryListBloc.dispatch(DiaryListEventSnapPage(pageIndex: page)),
                  physics: ClampingScrollPhysics(),
                ),
              ),
              SizedBox(height: 10.0),
              _diaryDetailBuilder(_currentPage)
            ],
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
            offset: Offset(0, 100 + (-value*100)),
            child: Opacity(
              opacity: value,
              child: Column(
                children: [
                  SmoothStarRating(
                    color: Colors.red,
                    borderColor: Colors.black,
                    size: 40.0,
                    rating: _diaryList[index].rating,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    _diaryList[index].title,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    _diaryList[index].contents,
                    style: TextStyle(
                      fontSize: 20.0,
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
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs()*0.5)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(value) * 600,
              child: child
            ),
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(index==0 ? value : value*0.5) * 600,
              child: child
            ),
          );
        }
      },
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)
            ),
            child: CachedNetworkImage(
              imageUrl: _diaryList[index].movie.mainPhoto,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}