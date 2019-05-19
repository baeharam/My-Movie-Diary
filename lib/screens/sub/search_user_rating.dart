
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/colors.dart';

class SearchUserRating extends StatelessWidget {

  final MovieModel movie;

  const SearchUserRating({Key key, this.movie}) : super(key: key);

  Widget _buildStar(int index) {
    Icon icon;
    double changedRating = double.parse(movie.userRating)/2;
    if(index>=changedRating) {
      icon = Icon(
        Icons.star_border,
        color: AppColor.searchStar,
      );
    } else if(index>changedRating-1 && index<changedRating) {
      icon = Icon(
        Icons.star_half,
        color: AppColor.searchStar,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: AppColor.searchStar
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> ratingList = List.generate(5, (index) => _buildStar(index));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ratingList
    );
  }
}