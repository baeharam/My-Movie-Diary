
import 'package:flutter/material.dart';
import 'package:mymovie/models/movie_model.dart';

class MovieUserRating extends StatelessWidget {

  final MovieModel movie;

  const MovieUserRating({Key key, this.movie}) : super(key: key);

  Widget _buildStar(int index) {
    Icon icon;
    double changedRating = double.parse(movie.userRating)/2;
    if(index>=changedRating) {
      icon = Icon(
        Icons.star_border,
        color: Colors.yellow,
      );
    } else if(index>changedRating-1 && index<changedRating) {
      icon = Icon(
        Icons.star_half,
        color: Colors.yellow,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: Colors.yellow
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> ratingList = List.generate(5, (index) => _buildStar(index));
    ratingList.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
        movie.userRating,
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
    ),
      ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ratingList
    );
  }
}