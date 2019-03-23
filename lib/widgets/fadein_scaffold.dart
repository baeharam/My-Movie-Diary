import 'package:flutter/material.dart';

class FadeInScaffold extends StatefulWidget {

  final Widget body;

  FadeInScaffold({@required this.body});

  @override
  _FadeInScaffoldState createState() => _FadeInScaffoldState();
}

class _FadeInScaffoldState extends State<FadeInScaffold> with SingleTickerProviderStateMixin{

  AnimationController _fadeInController;
  Animation _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _fadeInController =AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000)
    );
    _fadeInAnimation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
      parent: _fadeInController,
      curve: Curves.easeIn
    ));
    _fadeInController.forward();
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: widget.body
      ),
    );
  }
}