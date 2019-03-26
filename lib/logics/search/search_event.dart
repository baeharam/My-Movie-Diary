import 'package:meta/meta.dart';

abstract class SearchEvent {}

class SearchEventStateClear extends SearchEvent {}

class SearchEventKeyboardChanged extends SearchEvent {
  final bool isKeyboardOn;
  SearchEventKeyboardChanged({@required this.isKeyboardOn});
}