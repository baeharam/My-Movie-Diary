import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:mymovie/logics/global/firebase_api.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:mymovie/screens/main/search_screen.dart';
import 'package:mymovie/utils/bloc_navigator.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:mymovie/widgets/modal_progress.dart';

import 'diary_list_screen.dart';
import 'home_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  List<ScreenHiddenDrawer> screens = List<ScreenHiddenDrawer>();
  StreamController<bool> streamController = StreamController<bool>();

  @override
  void initState() {
    super.initState();
    screens.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: '홈',
          colorLineSelected: Colors.teal
        ),
        HomeScreen()
      )
    );
    screens.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: '나의 영화일기',
          colorLineSelected: Colors.teal
        ),
        DiaryListScreen()
      )
    );
    screens.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: '영화일기 작성하기',
          colorLineSelected: Colors.teal
        ),
        SearchScreen()
      )
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        HiddenDrawerMenu(
          enablePerspective: true,
          backgroundColorMenu: Colors.blueGrey,
          backgroundColorAppBar: AppColor.darkBlueLight,
          actionsAppBar: [IconButton(icon: Icon(Icons.exit_to_app,color: Colors.white,)
            ,onPressed: () async{
              streamController.sink.add(true);
              await sl.get<FirebaseAPI>().signOut();
            })],
          screens: screens
        ),
        StreamBuilder(
          stream: streamController.stream,
          initialData: false,
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData && snapshot.data){
              BlocNavigator.pushReplacementNamed(context, routeIntro);
              return Material(
                type: MaterialType.transparency,
                child: ModalProgress(text: '로그아웃 중입니다...',)
              );
            }
            return Container();
          },
        )
      ],
    );
  }
}