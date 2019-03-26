import 'package:get_it/get_it.dart';
import 'package:mymovie/logics/intro/intro_bloc.dart';
import 'package:mymovie/logics/search/search_bloc.dart';

GetIt sl = GetIt();

void setup() {
  sl.registerLazySingleton<IntroBloc>(() => IntroBloc());
  sl.registerLazySingleton<SearchBloc>(() => SearchBloc());
}