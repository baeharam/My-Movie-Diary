import 'package:mymovie/bloc_helpers/bloc_event_state.dart';

abstract class IntroEvent extends BlocEvent {}

class IntroEventStateClear extends IntroEvent {}

class IntroEventKakaoLogin extends IntroEvent {}