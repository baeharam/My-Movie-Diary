import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class SearchIntroScreen extends StatefulWidget {
  @override
  _SearchIntroScreenState createState() => _SearchIntroScreenState();
}

class _SearchIntroScreenState extends State<SearchIntroScreen> with SingleTickerProviderStateMixin{

  final TextEditingController textEditingController =TextEditingController();
  final KeyboardVisibilityNotification keyboardVisibility =KeyboardVisibilityNotification();
  int subscriber;
  bool keyboardState;

  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000)
    );
    animation = Tween(
      begin: 100.0,
      end: 10.0
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut
    ));
    keyboardState = keyboardVisibility.isKeyboardVisible;
    subscriber = keyboardVisibility.addNewListener(
      onChange: (state){
        setState(() => keyboardState = state);
      }
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    textEditingController.dispose();
    keyboardVisibility.removeListener(subscriber);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final TextStyle textStyle =TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 25.0,
    );

    keyboardState ? animationController.forward() :animationController.reverse();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cinema.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
          ),
        ),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, widget){
            return Column(
              children: [
                SizedBox(height: animation.value),
                Container(
                  child: Column(
                    children: [
                      Text(
                        '일기를 작성하고자 하는',
                        style: textStyle,
                        textAlign: TextAlign.center
                      ),
                      SizedBox(height: 13.0),
                      Text(
                        '영화를 검색해주세요.',
                        style: textStyle,
                        textAlign: TextAlign.center
                      )
                    ],
                  )
                ),
                SizedBox(height: 100.0),
                Column(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(primaryColor: Colors.white),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: '영화',
                            labelStyle: Theme.of(context).textTheme
                              .caption.copyWith(color: Colors.white)
                          ),
                          autofocus: false,
                        ),
                      ),
                    ),
                    Container(
                      height: 3.0,
                      width: MediaQuery.of(context).size.width*0.9,
                      color: Colors.white,
                    )
                  ],
                )
              ],
            );
          }
        ),
      ),
    );
  }
}