
class SearchState {
  final bool isInitial;
  final bool isKeyboardOn;

  SearchState({
    this.isInitial,
    this.isKeyboardOn
  });

  factory SearchState.initial() => SearchState(isInitial: true);
  factory SearchState.keyboardOn() => SearchState(isKeyboardOn: true);
}