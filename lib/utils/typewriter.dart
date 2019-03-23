import 'dart:async';

import 'package:flutter/material.dart';

class TypeWriter extends StatefulWidget {
  final List<String> text;
  final TextStyle textStyle;
  final Duration duration;
  final AlignmentGeometry alignment;
  final TextAlign textAlign;
  final StreamController<bool> streamController;

  TypeWriter(
      {Key key,
      @required this.text,
      this.textStyle,
      @required this.duration,
      this.alignment = AlignmentDirectional.topStart,
      this.textAlign = TextAlign.start,
      this.streamController
      })
      : super(key: key);

  @override
  _TypewriterState createState() => new _TypewriterState();
}

class _TypewriterState extends State<TypeWriter> with SingleTickerProviderStateMixin {
  Duration _duration;

  List<Animation<int>> _typewriterText = [];

  List<Widget> textWidgetList = [];

  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _duration = widget.duration;

    _controller = new AnimationController(
      duration: _duration,
      vsync: this,
    );

    _controller.forward();

    _controller.addStatusListener((AnimationStatus status){
      if(status==AnimationStatus.completed && widget.streamController!=null){
        widget.streamController.sink.add(true);
      }
    });

    for (int i = 0; i < widget.text.length; i++) {
      _typewriterText.add(StepTween(begin: 0, end: widget.text[i].length)
          .animate(new CurvedAnimation(
              parent: _controller,
              curve: Curves.linear)));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.text.length; i++) {
      textWidgetList.add(AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Builder(
            builder: (BuildContext context) {
              String visibleString = widget.text[i];
              if (_typewriterText[i].value == 0) {
                visibleString = "";
              } else if (_typewriterText[i].value > widget.text[i].length) {
                visibleString = widget.text[i].substring(0, widget.text[i].length);
              } else {
                visibleString = widget.text[i].substring(0, _typewriterText[i].value);
              }
              return Text(
                visibleString,
                style: widget.textStyle,
                textAlign: widget.textAlign,
              );
            },
          );
        },
      ));
    }

    return Stack(
      alignment: widget.alignment,
      children: textWidgetList,
    );
  }
}
