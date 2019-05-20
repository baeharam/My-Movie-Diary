class DiaryResultState {
  final bool isInitial;

  final bool isDeleteLoading;
  final bool isDeleteSucceeded;
  final bool isDeleteFailed;

  DiaryResultState({
    this.isInitial: false,

    this.isDeleteLoading: false,
    this.isDeleteSucceeded: false,
    this.isDeleteFailed: false
  });


  factory DiaryResultState.initial() => DiaryResultState(isInitial: true);

  factory DiaryResultState.deleteLoading() => DiaryResultState(isDeleteLoading: true);
  factory DiaryResultState.deleteSucceeded() => DiaryResultState(isDeleteSucceeded: true);
  factory DiaryResultState.deleteFailed() => DiaryResultState(isDeleteFailed: true);
}