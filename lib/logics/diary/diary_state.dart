
import 'package:meta/meta.dart';

class DiaryState {
  final bool isInitial;

  final bool isStarClicked;
  final double value;

  const DiaryState({
    this.isInitial: false,
    
    this.isStarClicked: false,
    this.value: 0.0
  });


  factory DiaryState.initial() => DiaryState(isInitial: true);
  
  factory DiaryState.starClicked({@required double value}) 
    => DiaryState(isStarClicked: true, value: value);
}