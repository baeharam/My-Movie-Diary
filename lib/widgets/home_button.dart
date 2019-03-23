import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;

  HomeButton({
    @required this.title,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      height: 60.0,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.0
          ),
        ),
        elevation: 5.0,
        onPressed: onPressed,
      ),
    );
  }
}