import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/diary/diary.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DiaryScreen extends StatefulWidget {

  final MovieModel movie;

  const DiaryScreen({Key key, @required this.movie}) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {

  final DiaryBloc _diaryBloc = sl.get<DiaryBloc>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _feelingController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _feelingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
              SizedBox(height: 60.0),
              BlocBuilder<DiaryEvent,DiaryState>(
                bloc: _diaryBloc,
                builder: (context,state){
                  return SmoothStarRating(
                    borderColor: Colors.grey,
                    color: Colors.red,
                    rating: state.star,
                    allowHalfRating: true,
                    size: 40.0,
                    onRatingChanged: (value) => 
                      _diaryBloc.dispatch(DiaryEventStarClick(value: value)),
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
                        _diaryBloc.dispatch(DiaryEventTitleChange(title: title)),
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
                    _diaryBloc.dispatch(DiaryEventFeelingChange(feeling: feeling)),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<DiaryEvent,DiaryState>(
          bloc: _diaryBloc,
          builder: (context, state){
            if(state.star==0.0 || state.feeling.isEmpty || state.title.isEmpty){
              return Container();
            }
            return FloatingActionButton.extended(
              backgroundColor: Colors.blueGrey,
              icon: Icon(Icons.save, color: Colors.black),
              label: Text(
                '다썼어요!',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: (){},
            );
          }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}