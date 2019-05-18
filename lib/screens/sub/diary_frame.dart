import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/diary_edit/diary_edit.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/screens/main/diary_edit_screen.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class DiaryFrame extends StatefulWidget {

  final MovieModel movie;

  const DiaryFrame({Key key, @required this.movie}) : super(key: key);

  @override
  _DiaryFrameState createState() => _DiaryFrameState();
}

class _DiaryFrameState extends State<DiaryFrame> {

  final DiaryEditBloc _diaryBloc = sl.get<DiaryEditBloc>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _feelingController = TextEditingController();

  double _rating;

  @override
  void dispose() {
    _titleController.dispose();
    _feelingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
          SizedBox(height: 60.0),
          BlocBuilder<DiaryEditEvent,DiaryEditState>(
            bloc: _diaryBloc,
            builder: (context,state){
              if(state.star>0.0) {
                _rating = state.star;
              }
              return Row(
                children: <Widget>[
                  SmoothStarRating(
                    borderColor: Colors.grey,
                    color: Colors.red,
                    rating: state.star,
                    allowHalfRating: true,
                    size: 40.0,
                    onRatingChanged: (value) => 
                      _diaryBloc.dispatch(DiaryEditEventStarClick(value: value)),
                  ),
                  Spacer(),
                  (state.star==0.0 || 
                    state.feeling.isEmpty || 
                    state.title.isEmpty) 
                  ? Container(height: 50.0)
                  : DiaryCompleteButton(
                    diaryModel: DiaryModel(
                      movieMainPhoto: widget.movie.mainPhoto,
                      movieTitle: widget.movie.title,
                      movieCode: widget.movie.movieCode,
                      moviePubDate: widget.movie.pubDate,
                      movieStillCutList: widget.movie.stillcutList,
                      diaryTitle: _titleController.text,
                      diaryContents: _feelingController.text,
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
                hintText: '제목',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 40.0
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0
              ),
              maxLines: 1,
              cursorColor: Colors.white,
              controller: _titleController,
              onChanged: (title) => 
                    _diaryBloc.dispatch(DiaryEditEventTitleChange(title: title)),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.transparent),
            child: TextField(
              decoration: InputDecoration(
                hintText: '느낀점',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 30.0
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                height: 1.2
              ),
              cursorColor: Colors.white,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _feelingController,
              onChanged: (feeling) => 
                _diaryBloc.dispatch(DiaryEditEventFeelingChange(feeling: feeling)),
            ),
          )
        ],
      );
  }
}