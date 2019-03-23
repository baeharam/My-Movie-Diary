import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/utils/typewriter.dart';
import 'package:mymovie/widgets/home_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  StreamController<bool> _streamController;
  AnimationController _fadeAnimationController;
  Animation _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<bool>();
    _fadeAnimationInitialization();
  }

  @override
  void dispose() {
    _streamController.close();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  void _fadeAnimationInitialization() {
    _fadeAnimationController =AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000)
    );
    _fadeAnimation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeIn
    ));
    _fadeAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
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
            child: Column(
              children: [
                SizedBox(
                  width: 250.0,
                  child: TypeWriter(
                    text: ['우주는 황홀했다.'],
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
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
                          text: ['인터스텔라, 2014'],
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
                ),
                SizedBox(height: 200.0),
                HomeButton(
                  title: '나의 영화일기', 
                  onPressed: (){}
                ),
                SizedBox(height: 20.0),
                HomeButton(
                  title: '영화일기 작성하기', 
                  onPressed: () => Navigator.pushNamed(context, routeSearch)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}