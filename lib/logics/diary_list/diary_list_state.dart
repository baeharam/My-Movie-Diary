import 'package:meta/meta.dart';

class DiaryListState {
  final bool isInitial;

  final bool isPageSnapped;
  final int pageIndex;

  final bool isDeleteLoading;
  final bool isDeleteSucceeded;
  final bool isDeleteFailed;


  const DiaryListState({
    this.isInitial: false,

    this.isPageSnapped: false,
    this.pageIndex: 0,

    this.isDeleteLoading: false,
    this.isDeleteSucceeded: false,
    this.isDeleteFailed: false
  });

  factory DiaryListState.initial() => DiaryListState(isInitial: true);

  factory DiaryListState.pageSnapped({@required int index}) 
    => DiaryListState(isPageSnapped: true, pageIndex: index);

  factory DiaryListState.deleteLoading() => DiaryListState(isDeleteLoading: true);
  factory DiaryListState.deleteSucceeded() => DiaryListState(isDeleteSucceeded: true);
  factory DiaryListState.deleteFailed() => DiaryListState(isDeleteFailed: true);
}