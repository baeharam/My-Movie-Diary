import 'package:flutter/material.dart';

class MovieMoreDescription extends StatelessWidget {

  final String description;

  const MovieMoreDescription({Key key, @required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*1.2,
          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
          alignment: Alignment.center,
          color: Colors.black,
          child: Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              height: 1.5
            ),
          ),
        ),
      ),
    );
  }
}