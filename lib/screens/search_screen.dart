import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mymovie/logics/search/search.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/widgets/fadein_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin{

  final SearchBloc _searchBloc = sl.get<SearchBloc>(); 
  final TextEditingController _textEditingController =TextEditingController();
  final KeyboardVisibilityNotification _keyboardVisibility =KeyboardVisibilityNotification();


  int _subscriber;
  AnimationController _searchAnimationController;
  Animation _liftUpAnimation,_fadeOutAnimation;

  List<MovieModel> _movieList = List<MovieModel>();

  @override
  void initState() {
    super.initState();
    _searchAnimationInitialization();
    _keyboardListenerInitialization();
  }

  @override
  void dispose() {
    _searchAnimationController.dispose();
    _textEditingController.dispose();
    _keyboardVisibility.removeListener(_subscriber);
    super.dispose();
  }

  void _searchAnimationInitialization() {
    _searchAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );
    _liftUpAnimation = Tween(begin: 150.0,end: 0.0)
    .animate(CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeOut
    ));
    _fadeOutAnimation = Tween(begin: 1.0, end: 0.0)
    .animate(CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeIn
    ));
  }

  void _keyboardListenerInitialization() {
    _subscriber = _keyboardVisibility.addNewListener(
      onChange: (state) {
        state 
        ? _searchBloc.dispatch(SearchEventKeyboardOn())
        :_searchBloc.dispatch(SearchEventKeyboardOff());
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeInScaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cinema.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
          ),
        ),
        child: BlocBuilder<SearchEvent, SearchState>(
          bloc: _searchBloc,
          builder: (context, state) {
            if(state.isKeyboardOn) {
              _searchAnimationController.forward();
            }
            if(state.isKeyboardOff && _movieList.isEmpty) {
              _searchAnimationController.reverse();
              _textEditingController.clear();
            }
            if(state.isMovieDataFetched) {
              _movieList = state.movieList;
            }
            return AnimatedBuilder(
              animation: _liftUpAnimation,
              builder: (context, widget){
                return Column(
                  children: [
                    SizedBox(height: _liftUpAnimation.value),
                    Opacity(
                      opacity: _fadeOutAnimation.value,
                      child: Container(
                        width: double.infinity,
                        height: _liftUpAnimation.value,
                        child: _liftUpAnimation.value>80.0 ? Column(
                          children: [
                            Text(
                              '일기를 작성하고자 하는',
                              style: searchScreenTextStyle,
                              textAlign: TextAlign.center
                            ),
                            SizedBox(height: 13.0),
                            Text(
                              '영화를 검색해주세요.',
                              style: searchScreenTextStyle,
                              textAlign: TextAlign.center
                            )
                          ],
                        ) : Container(),
                      )
                    ),
                    SizedBox(height: 100.0),
                    Column(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(primaryColor: Colors.white),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: '영화',
                                labelStyle: Theme.of(context).textTheme
                                  .caption.copyWith(color: Colors.white),
                              ),
                              controller: _textEditingController,
                              autofocus: false,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              onChanged: (text) {
                                _searchBloc.dispatch(SearchEventTextChanged(text: text));
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 3.0,
                          width: MediaQuery.of(context).size.width*0.9,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _movieList.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: <Widget>[
                              SearchMovieForm(
                                movie: _movieList[index]
                              ),
                              SizedBox(height: 50.0)
                            ],
                          );
                        }
                      )
                    )
                  ],
                );
              }
            );
          }
        ),
      ),
    );
  }
}

class SearchMovieForm extends StatelessWidget {

  final MovieModel movie;

  SearchMovieForm({@required this.movie});

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 5.0,
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width*0.7,
            height: 150,
          ),
          Positioned(
            left: 10.0,
            child: movie.image.isNotEmpty 
              ? CachedNetworkImage(
                imageUrl: movie.image,
                placeholder: (_,__) {
                  return Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  );
                },
                errorWidget: (_,__,___) => Container(child:Icon(Icons.error)),
              )
              : Container(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('이미지 없음')
              ),
          ),
          Positioned(
            right: 0.0,
            height: 150.0,
            width: MediaQuery.of(context).size.width*0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Text(
                  movie.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.0),
                Text(
                  movie.director,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  movie.actor,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Text(
                  movie.pubDate,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            )
          )
        ],
      ),
    );
  }
}