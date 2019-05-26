import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mymovie/logics/global/animation_api.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/models/intro_message_model.dart';
import 'package:mymovie/utils/orientation_fixer.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/utils/typewriter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  StreamController<bool> _streamController;
  IntroMessageModel _introMessageModel;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<bool>();
    sl.get<AnimationAPI>().initHome(vsync: this);
    _introMessageModel = sl.get<CurrentUser>().getRandomIntro();
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
          width: 250.0,
          child: TypeWriter(
            text: [_introMessageModel.line],
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
            alignment: Alignment.center,
            streamController: _streamController,
            duration: const Duration(milliseconds: 2500),
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
                  text: ['${_introMessageModel.movieTitle}, ' 
                    '${_introMessageModel.pubDate}'],
                  textStyle: TextStyle(
                    color: Colors.white,
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
              image: AssetImage('assets/images/fantasy.jpg'),
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