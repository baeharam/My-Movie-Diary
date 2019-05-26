import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Image image;
  final Color buttonColor;
  final Color textColor;
  final Color loadingColor;
  final String message;
  final VoidCallback callback;


  LoginButton({
    Key key,
    @required this.image,
    @required this.buttonColor,
    @required this.textColor,
    @required this.loadingColor,
    @required this.message,
    @required this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 300.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 20.0),
            image,
            Container(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20.0
                ),
              ),
            )
          ],
        )
      ),
      onTap: () => callback
    );
  }
}