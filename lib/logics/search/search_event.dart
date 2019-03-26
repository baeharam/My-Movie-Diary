import 'package:meta/meta.dart';

abstract class SearchEvent {}

class SearchEventStateClear extends SearchEvent {}

class SearchEventKeyboardOn extends SearchEvent {}

class SearchEventKeyboardOff extends SearchEvent {}

class SearchEventTextChanged extends SearchEvent {
  final String text;
  SearchEventTextChanged({@required this.text});
}