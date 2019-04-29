class DiaryState {
  final bool isInitial;

  final bool isStarClicked;
  final double star;

  final bool isTitleNotEmpty;
  final String title;

  final bool isFeelingNotEmpty;
  final String feeling;

  const DiaryState({
    this.isInitial: false,

    this.isStarClicked: false,
    this.star: 0.0,

    this.isTitleNotEmpty: false,
    this.title: '',

    this.isFeelingNotEmpty: false,
    this.feeling: ''
  });


  factory DiaryState.initial() => DiaryState(isInitial: true);

  DiaryState copyWith({
    double star,
    bool isStarClicked,
    String title,
    bool isTitleNotEmpty,
    String feeling,
    bool isFeelingNotEmpty
  }) {
    return DiaryState(
      star: star ?? this.star,
      isStarClicked: isStarClicked ?? this.isStarClicked,
      title: title ?? this.title,
      isTitleNotEmpty: isTitleNotEmpty ?? this.isTitleNotEmpty,
      feeling: feeling ?? this.feeling,
      isFeelingNotEmpty: isFeelingNotEmpty ?? this.isFeelingNotEmpty
    );
  }
}