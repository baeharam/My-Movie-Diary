import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;

  HomeButton({
    Key key,
    @required this.title,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.white)
        ),
        width: 250.0,
        height: 55.0,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0
          ),
        ),
      ),
    );
  }
}