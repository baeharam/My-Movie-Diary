import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mymovie/logics/search/search.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/main/movie_screen.dart';
import 'package:mymovie/screens/sub/search_sub.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/orientation_fixer.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/widgets/modal_progress.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin{

  final SearchBloc _searchBloc = sl.get<SearchBloc>(); 
  final TextEditingController _searchBarController =TextEditingController();
  final KeyboardVisibilityNotification _keyboardVisibility = KeyboardVisibilityNotification();

  int _keyboardSubscriber;
  AnimationController _searchAnimationController;
  Animation _liftUpAnimation,_fadeOutAnimation;
  List<MovieModel> _movieList = List<MovieModel>();

  @override
  void initState() {
    super.initState();
    _searchBloc.dispatch(SearchEventStateClear());
    _searchAnimationInitialization();
    _keyboardListenerInitialization();
  }

  @override
  void dispose() {
    _searchAnimationController.dispose();
    _searchBarController.dispose();
    _keyboardVisibility.removeListener(_keyboardSubscriber);
    _searchBloc.dispatch(SearchEventStateClear());
    super.dispose();
  }

  void _searchAnimationInitialization() {
    _searchAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
    _liftUpAnimation = Tween(begin: 100.0,end: 0.0)
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
    _keyboardSubscriber = _keyboardVisibility.addNewListener(
      onChange: (state) {
        state 
        ? _searchBloc.dispatch(SearchEventKeyboardOn())
        :_searchBloc.dispatch(SearchEventKeyboardOff());
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    OrientationFixer.fixPortrait();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.darkBlueDark
      ),
      child: BlocBuilder<SearchEvent, SearchState>(
        bloc: _searchBloc,
        builder: (context, state) {
          if(state.isKeyboardOn) {
            _searchAnimationController.forward();
          }
          if(state.isKeyboardOff && _movieList.isEmpty) {
            _searchAnimationController.reverse();
            _searchBarController.clear();
          }
          if(state.isMovieAPICallSucceeded) {
            _movieList = state.movieList;
          }
          
          if(state.isMovieCrawlSucceeded) {
            _searchBloc.dispatch(SearchEventStateClear());
            BlocNavigator.push(context, 
              MaterialPageRoute(builder: (_)=>MovieScreen(movie: state.clickedMovie)));
          }
          if(state.isMovieCrawlLoading || state.isMovieCrawlSucceeded) {
            return ModalProgress(text: '영화를 가져오고 있습니다...');
          }
          return AnimatedBuilder(
            animation: _liftUpAnimation,
            builder: (context, widget){
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(height: _liftUpAnimation.value),
                      SearchMessage(
                        fadeOutAnimation: _fadeOutAnimation,
                        liftUpAnimation: _liftUpAnimation
                      ),
                      SizedBox(height: 100.0),
                      Column(
                        children: [
                          SearchBar(
                            searchBarController: _searchBarController,
                            searchBloc: _searchBloc,
                          ),
                          Container(
                            height: 3.0,
                            width: MediaQuery.of(context).size.width*0.9,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      SearchResultForm(
                        movieList: _movieList,
                        searchBloc: _searchBloc,
                        searchBarController: _searchBarController,
                      )
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}
