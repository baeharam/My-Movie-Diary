import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:mymovie/resources/colors.dart';
import 'package:mymovie/screens/main/search_screen.dart';

import 'diary_list_screen.dart';
import 'home_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  List<ScreenHiddenDrawer> screens = List<ScreenHiddenDrawer>();

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
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      enablePerspective: true,
      backgroundColorMenu: Colors.blueGrey,
      backgroundColorAppBar: AppColor.background,
      tittleAppBar: Text('하하'),
      screens: screens
    );
  }
}