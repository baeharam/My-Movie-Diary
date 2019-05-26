import 'package:get_it/get_it.dart';
import 'package:mymovie/logics/diary_edit/diary_edit_bloc.dart';
import 'package:mymovie/logics/diary_list/diary_list_bloc.dart';
import 'package:mymovie/logics/global/animation_api.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/logics/global/database_api.dart';
import 'package:mymovie/logics/global/firebase_api.dart';
import 'package:mymovie/logics/intro/intro_bloc.dart';
import 'package:mymovie/logics/movie/movie_bloc.dart';
import 'package:mymovie/logics/search/search_bloc.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerLazySingleton<IntroBloc>(() => IntroBloc());
  sl.registerLazySingleton<SearchBloc>(() => SearchBloc());
  sl.registerLazySingleton<MovieBloc>(() => MovieBloc());
  sl.registerLazySingleton<DiaryEditBloc>(() => DiaryEditBloc());
  sl.registerLazySingleton<DiaryListBloc>(() => DiaryListBloc());

  sl.registerLazySingleton<CurrentUser>(() => CurrentUser());
  sl.registerLazySingleton<FirebaseAPI>(() => FirebaseAPI());
  sl.registerLazySingleton<DatabaseAPI>(() => DatabaseAPI());
  sl.registerLazySingleton<AnimationAPI>(() => AnimationAPI());
}