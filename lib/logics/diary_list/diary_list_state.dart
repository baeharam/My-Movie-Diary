import 'package:meta/meta.dart';

class DiaryListState {
  final bool isInitial;

  final bool isPageSnapped;
  final int pageIndex;


  const DiaryListState({
    this.isInitial: false,

    this.isPageSnapped: false,
    this.pageIndex: 0,
  });

  factory DiaryListState.initial() => DiaryListState(isInitial: true);

  factory DiaryListState.pageSnapped({@required int index}) 
    => DiaryListState(isPageSnapped: true, pageIndex: index);
}