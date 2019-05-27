import 'package:flutter/material.dart';
import 'package:mymovie/logics/diary_list/diary_list.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/screens/main/diary_edit_screen.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DiaryDetail extends StatefulWidget {

  final int index;

  const DiaryDetail({Key key, @required this.index}) : super(key: key);

  @override
  _DiaryDetailState createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white,width: 2.0)),
              ),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.create,size: 30.0,color: Colors.white,),
                    Text(
                      '수정',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    )
                  ],
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DiaryEditScreen(
                    diary: sl.get<CurrentUser>().diaryList[widget.index],
                    isEditing: true,
                  ))),
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white,width: 2.0)),
              ),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.delete,size: 30.0,color: Colors.white,),
                    Text(
                      '삭제',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    )
                  ],
                ),
                onTap: () => 
                  sl.get<DiaryListBloc>().dispatch(DiaryListEventDelete(diary: 
                    sl.get<CurrentUser>().diaryList[widget.index])),
              ),
            )
          ],
        ),
        SizedBox(height: 20.0),
        SmoothStarRating(
          color: Colors.red,
          borderColor: Colors.white,
          size: 40.0,
          rating: sl.get<CurrentUser>().diaryList[widget.index].diaryRating,
        ),
        SizedBox(height: 20.0),
        Text(
          sl.get<CurrentUser>().diaryList[widget.index].diaryTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        SizedBox(height: 20.0,),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: Text(
            sl.get<CurrentUser>().diaryList[widget.index].diaryContents,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ]
    );
  }
}