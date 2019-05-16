import 'package:meta/meta.dart';
import 'package:mymovie/models/diary_model.dart';

class DiaryEditState {
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

  const DiaryEditState({
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


  factory DiaryEditState.initial() => DiaryEditState(isInitial: true);
  factory DiaryEditState.completeLoading() => DiaryEditState(isDiaryCompleteLoading: true);
  factory DiaryEditState.completeSucceeded({@required DiaryModel diaryModel}) => 
    DiaryEditState(isDiaryCompleteSucceeded: true,diaryModel: diaryModel);
  factory DiaryEditState.completeFailed() => DiaryEditState(isDiaryCompleteFailed: true);   

  DiaryEditState copyWith({
    double star,
    bool isStarClicked,
    String title,
    bool isTitleNotEmpty,
    String feeling,
    bool isFeelingNotEmpty,
    bool isKeyboardOn,
    bool isKeyboardOff
  }) {
    return DiaryEditState(
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