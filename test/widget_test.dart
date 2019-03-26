import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mymovie/screens/intro_screen.dart';
import 'package:mymovie/utils/service_locator.dart';

void main() {
  setup();

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child
    );
  }

  testWidgets('Test for IntroScreen', (WidgetTester tester) async {
    IntroScreen introScreen = IntroScreen();
    await tester.pumpWidget(makeTestableWidget(child: introScreen));
  });
}