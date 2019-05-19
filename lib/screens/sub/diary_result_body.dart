import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DiaryResultBody extends StatelessWidget {

  final DiaryModel diaryModel;
  final int randomIndex;

  const DiaryResultBody({
    Key key, 
    @required this.diaryModel, 
    @required this.randomIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.background
          ),
          height: MediaQuery.of(context).size.height
        ),
        Card(
          color: AppColor.diaryResultComponent,
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.0),
              Hero(
                tag: diaryModel.movieCode,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: diaryModel.movieStillCutList[randomIndex],
                      placeholder: (_,__) {
                        return SizedBox(
                          width: 300.0,
                          height: 300.0,
                          child: Center(
                            child: SpinKitWave(
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SmoothStarRating(
                      borderColor: Colors.grey,
                      color: Colors.red,
                      rating: diaryModel.diaryRating,
                      size: 40.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      diaryModel.diaryTitle,
                      style: TextStyle(
                        color: AppColor.diaryResultText,
                        fontSize: 40.0
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      diaryModel.diaryContents,
                      style: TextStyle(
                        color: AppColor.diaryResultText,
                        fontSize: 20.0
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}