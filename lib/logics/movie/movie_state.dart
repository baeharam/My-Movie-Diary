
class MovieState {
  final bool isInitial;

  final bool isMoreButtonClicked;
  final bool isFoldButtonClicked;

  const MovieState({
    this.isInitial: false,
    
    this.isMoreButtonClicked: false,
    this.isFoldButtonClicked: false
  });


  factory MovieState.initial() => MovieState(isInitial: true);
  
  factory MovieState.moreButtonClicked() => MovieState(isMoreButtonClicked: true);
  factory MovieState.foldButtonClicked() => MovieState(isFoldButtonClicked: true);
}