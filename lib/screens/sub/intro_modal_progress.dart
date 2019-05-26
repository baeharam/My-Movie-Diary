import 'package:flutter/material.dart';
import 'package:mymovie/resources/colors.dart';

class IntroModalProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.8)
        ),
        Container(
          width: 200.0,
          height: 150.0,
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black,width: 2.0)
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
            SizedBox(height: 20.0),
            Text(
              '로그인 중입니다....',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        )
      ],
    );
  }
}