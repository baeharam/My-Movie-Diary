
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  
  final Color color;
  CustomProgressIndicator({@required this.color});
  
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color),
    );
  }
}