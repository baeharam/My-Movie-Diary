import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/diary_edit/diary_edit.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/screens/main/diary_edit_screen.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class DiaryEditFrame extends StatefulWidget {

  final DiaryModel diary;
  final bool isEditing;

  const DiaryEditFrame({Key key, @required this.diary, @required this.isEditing}) : super(key: key);

  @override
  _DiaryEditFrameState createState() => _DiaryEditFrameState();
}

class _DiaryEditFrameState extends State<DiaryEditFrame> {

  final DiaryEditBloc _diaryEditBloc = sl.get<DiaryEditBloc>();
  TextEditingController _titleController;
  TextEditingController _contentsController;
  double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.diary.diaryRating ?? 0.0;
    _titleController = TextEditingController(text: widget.diary.diaryTitle ?? '');
    _contentsController = TextEditingController(text: widget.diary.diaryContents ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
          SizedBox(height: 60.0),
          BlocBuilder<DiaryEditEvent,DiaryEditState>(
            bloc: _diaryEditBloc,
            builder: (context,state){
              if(state.star>0.0) {
                _rating = state.star;
              }
              return Row(
                children: <Widget>[
                  SmoothStarRating(
                    borderColor: Colors.white70,
                    color: Colors.red,
                    rating: _rating,
                    allowHalfRating: true,
                    size: 40.0,
                    onRatingChanged: (value) => 
                      _diaryEditBloc.dispatch(DiaryEditEventStarClick(value: value)),
                  ),
                  Spacer(),
                  ((state.star==0.0 || 
                    state.feeling.isEmpty || 
                    state.title.isEmpty) && !widget.isEditing) 
                  ? Container(height: 50.0)
                  : DiaryCompleteButton(
                    isEditing: widget.isEditing,
                    diaryModel: widget.diary.copyWith(
                      diaryTitle: _titleController.text,
                      diaryContents: _contentsController.text,
                      diaryRating: _rating
                    ),
                  )
                ],
              );
            }
          ),
          SizedBox(height: 20.0),
          Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.transparent),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '제목',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 30.0
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0
              ),
              maxLines: 1,
              cursorColor: Colors.white,
              controller: _titleController,
              onChanged: (title) => 
                    _diaryEditBloc.dispatch(DiaryEditEventTitleChange(title: title)),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.transparent),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '느낀점',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                height: 1.2
              ),
              cursorColor: Colors.white,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _contentsController,
              onChanged: (content) => 
                _diaryEditBloc.dispatch(DiaryEditEventContentsChange(contents: content)),
            ),
          )
        ],
      );
  }
}