import 'package:flutter/material.dart';

class WhiteLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.0,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.white,
    );
  }
}