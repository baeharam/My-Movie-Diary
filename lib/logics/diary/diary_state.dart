import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';

class DiaryState {
  final bool isInitial;

  final bool isStarClicked;
  final double star;

  final bool isTitleNotEmpty;
  final String title;

  final bool isFeelingNotEmpty;
  final String feeling;

  final bool isKeyboardOn;
  final bool isKeyboardOff;

  final bool isDiaryCompleteLoading;
  final bool isDiaryCompleteSucceeded;
  final DiaryModel diaryModel;
  final bool isDiaryCompleteFailed;

  const DiaryState({
    this.isInitial: false,

    this.isStarClicked: false,
    this.star: 0.0,

    this.isTitleNotEmpty: false,
    this.title: '',

    this.isFeelingNotEmpty: false,
    this.feeling: '',

    this.isKeyboardOn: false,
    this.isKeyboardOff: false,

    this.isDiaryCompleteLoading: false,
    this.isDiaryCompleteSucceeded: false,
    this.diaryModel,
    this.isDiaryCompleteFailed: false
  });


  factory DiaryState.initial() => DiaryState(isInitial: true);
  factory DiaryState.completeLoading() => DiaryState(isDiaryCompleteLoading: true);
  factory DiaryState.completeSucceeded({@required DiaryModel diaryModel}) => 
    DiaryState(isDiaryCompleteSucceeded: true,diaryModel: diaryModel);
  factory DiaryState.completeFailed() => DiaryState(isDiaryCompleteFailed: true);   

  DiaryState copyWith({
    double star,
    bool isStarClicked,
    String title,
    bool isTitleNotEmpty,
    String feeling,
    bool isFeelingNotEmpty,
    bool isKeyboardOn,
    bool isKeyboardOff
  }) {
    return DiaryState(
      star: star ?? this.star,
      isStarClicked: isStarClicked ?? this.isStarClicked,
      title: title ?? this.title,
      isTitleNotEmpty: isTitleNotEmpty ?? this.isTitleNotEmpty,
      feeling: feeling ?? this.feeling,
      isFeelingNotEmpty: isFeelingNotEmpty ?? this.isFeelingNotEmpty,
      isKeyboardOn: isKeyboardOn ?? this.isKeyboardOn,
      isKeyboardOff: isKeyboardOff ?? this.isKeyboardOff
    );
  }
}