import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymovie/logics/global/animation_api.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/utils/orientation_fixer.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/utils/typewriter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  StreamController<bool> _streamController;
  DiaryModel _diaryModel;
  String realLine = "";

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<bool>();
    sl.get<AnimationAPI>().initHome(vsync: this);
    _diaryModel = sl.get<CurrentUser>().getRandomDiary();
    realLine = "\""+
      (_diaryModel==null ? '영화는 예술이다.' :
      _diaryModel.movieLineList[Random().nextInt(_diaryModel.movieLineList.length)])
    +"\"";
  }

  @override
  void dispose() {
    _streamController.close();
    sl.get<AnimationAPI>().disposeHome();
    super.dispose();
  }

  Widget _buildTypeWriting() {
    return Column(
      children: [
        SizedBox(
          width: 300.0,
          child: TypeWriter(
            text: [realLine],
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
            alignment: Alignment.center,
            streamController: _streamController,
            duration: const Duration(milliseconds: 5000),
          ),
        ),
        SizedBox(height: 40.0),
        Container(
          color: Colors.white,
          width: 200.0,
          height: 4.0,
        ),
        SizedBox(height: 20.0),
        StreamBuilder<bool>(
          stream: _streamController.stream,
          initialData: false,
          builder: (context, AsyncSnapshot<bool> snapshot){
            if(snapshot.hasData && snapshot.data) {
              return  SizedBox(
                height: 25.0,
                child: TypeWriter(
                  text: [_diaryModel==null ? '개발자, 2019' : '${_diaryModel.movieTitle}, ' 
                    '${_diaryModel.moviePubDate}'],
                  textStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 20.0,
                  ),
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 2500),
                ),
              );
            }
            return SizedBox(height: 25.0);
          }
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    OrientationFixer.fixPortrait();

    return FadeTransition(
      opacity: sl.get<AnimationAPI>().homeAnimation,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _diaryModel==null ?
              AssetImage('assets/images/fantasy.jpg'):
              CachedNetworkImageProvider(
                _diaryModel.movieMainPhoto
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 200.0),
            child: _buildTypeWriting()
          ),
        ),
      ),
    );
  }
}