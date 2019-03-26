
class SearchState {
  final bool isInitial;
  final bool isKeyboardOn;
  final bool isKeyboardOff;

  SearchState({
    this.isInitial: false,
    this.isKeyboardOn: false,
    this.isKeyboardOff: false
  });

  factory SearchState.initial() => SearchState(isInitial: true);
  factory SearchState.keyboardOn() => SearchState(isKeyboardOn: true);
  factory SearchState.keyboardOff() => SearchState(isKeyboardOff: true);
}