import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mymovie/logics/search/search.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/screens/movie_screen.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/widgets/fadein_scaffold.dart';
import 'package:mymovie/widgets/search_movie_form.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin{

  final SearchBloc _searchBloc = sl.get<SearchBloc>(); 
  final TextEditingController _textEditingController =TextEditingController();
  final KeyboardVisibilityNotification _keyboardVisibility =KeyboardVisibilityNotification();
  static const TextStyle searchScreenTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 25.0,
  );


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
            if(state.isMovieAPICallSucceeded) {
              _movieList = state.movieList;
            }
            if(state.isMovieCrawlSucceeded) {
              _searchBloc.dispatch(SearchEventStateClear());
              BlocNavigator.push(context, 
                MaterialPageRoute(builder: (_)=>MovieScreen(movie: state.clickedMovie)));
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
                              BlocBuilder(
                                bloc: _searchBloc,
                                builder: (context,SearchState state){
                                  if(state.isMovieCrawlLoading && 
                                    _movieList[index].movieCode==state.clickedMovieCode) {
                                    return Container(
                                      height: 100.0,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(30.0),
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                      )
                                    );
                                  }
                                  return SearchMovieForm(
                                    movie: _movieList[index],
                                    searchBloc: _searchBloc,
                                  );
                                }
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

