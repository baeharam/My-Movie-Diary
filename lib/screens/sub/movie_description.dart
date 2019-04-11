
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/movie/movie.dart';
import 'package:mymovie/utils/service_locator.dart';

class MovieDescription extends StatelessWidget {

  final String description;

  const MovieDescription({
    Key key, 
    @required this.description,
  }) : assert(description!=null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieEvent,MovieState>(
      bloc: sl.get<MovieBloc>(),
      builder: (context, state){
        return LayoutBuilder(
          builder: (_, size){
            TextSpan textSpan = TextSpan(
              text: description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 1.3
              )
            );

            TextPainter textPainter = TextPainter(
              maxLines: 7,
              textDirection: TextDirection.ltr,
              text: textSpan
            );

            textPainter.layout(maxWidth: size.maxWidth);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: state.isMoreButtonClicked ? null : MediaQuery.of(context).size.height*0.28,
                  color: Colors.black,
                  child: Text.rich(
                    textSpan,
                    overflow: state.isMoreButtonClicked ? null : TextOverflow.ellipsis,
                    maxLines: state.isMoreButtonClicked ? null : 7,
                  ),
                ),
                textPainter.didExceedMaxLines
                ? GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      state.isMoreButtonClicked ? '접어두기' : '더보기',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0
                      ),
                    ),
                  ),
                  onTap: () => state.isMoreButtonClicked 
                  ? sl.get<MovieBloc>().dispatch(MovieEventFoldButtonClicked())
                  : sl.get<MovieBloc>().dispatch(MovieEventMoreButtonClicked()),
                ) : Container()
              ],
            );
          }
        );
      }
    );
  }
}