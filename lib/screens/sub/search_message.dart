
import 'package:flutter/material.dart';

class SearchMessage extends StatelessWidget {

  static const TextStyle searchScreenTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 25.0,
  );

  final Animation fadeOutAnimation;
  final Animation liftUpAnimation;

  const SearchMessage({
    Key key, 
    @required this.fadeOutAnimation, 
    @required this.liftUpAnimation
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: fadeOutAnimation.value,
      child: Container(
        width: double.infinity,
        height: liftUpAnimation.value,
        child: liftUpAnimation.value>80.0 ? Column(
          children: [
            Text(
              '일기를 작성하고자 하는',
              style: searchScreenTextStyle,
              textAlign: TextAlign.center
            ),
            SizedBox(height: 13.0),
            Text(
              '영화를 검색해주세요.',
              style: searchScreenTextStyle,
              textAlign: TextAlign.center
            )
          ],
        ) : Container(),
      )
    );
  }
}