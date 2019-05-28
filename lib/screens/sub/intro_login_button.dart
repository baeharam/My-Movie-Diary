import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/logics/intro/intro.dart';
import 'package:mymovie/utils/service_locator.dart';

class LoginButton extends StatelessWidget {
  final Image image;
  final Color buttonColor;
  final Color textColor;
  final Color loadingColor;
  final String message;
  final VoidCallback callback;


  LoginButton({
    Key key,
    @required this.image,
    @required this.buttonColor,
    @required this.textColor,
    @required this.loadingColor,
    @required this.message,
    @required this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroEvent,IntroState>(
      bloc: sl.get<IntroBloc>(),
      builder: (context, state) {
        return GestureDetector(
          child: Container(
            width: 300.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: 20.0),
                image,
                Container(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20.0
                    ),
                  ),
                )
              ],
            )
          ),
          onTap: (state.isFacebookLoginLoading || state.isGoogleLoginLoading)?null:callback
        );
      }
    );
  }
}