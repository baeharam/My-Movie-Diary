import 'package:get_it/get_it.dart';
import 'package:mymovie/logics/diary/diary_bloc.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/logics/intro/intro_bloc.dart';
import 'package:mymovie/logics/movie/movie_bloc.dart';
import 'package:mymovie/logics/search/search_bloc.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerLazySingleton<IntroBloc>(() => IntroBloc());
  sl.registerLazySingleton<SearchBloc>(() => SearchBloc());
  sl.registerLazySingleton<MovieBloc>(() => MovieBloc());
  sl.registerLazySingleton<DiaryBloc>(() => DiaryBloc());
  sl.registerLazySingleton<CurrentUser>(() => CurrentUser());
}