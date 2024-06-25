import 'package:flutter/material.dart';
import 'package:realtime_chat/view/page/menu/chat_menu_page.dart';
import 'package:realtime_chat/view/page/menu/group_menu_page.dart';
import 'package:realtime_chat/view/page/menu/info_menu_page.dart';
import 'package:realtime_chat/view/page/menu/profile_menu_page.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> menu = [
     ChatMenuPage(),
     GroupMenuPage(),
     ProfileMenuPage(),
     InfoMenuPage()
  ];

  void changeMenu(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
