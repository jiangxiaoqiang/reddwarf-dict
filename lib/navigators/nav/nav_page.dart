import 'package:reddwarf_dict/includes.dart';
import 'package:reddwarf_dict/pages/dev/dev_word.dart';
import 'package:reddwarf_dict/pages/learn/new_word.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'nav_controller.dart';

class Nav extends StatelessWidget {
  const Nav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
          return GetBuilder<NavController>(
              init:NavController(),
              builder:(controller) {
                void _onItemTapped(int index) {
                  if (index == 0) {
                    Widget widget = HomePage();
                    controller.updateCurrentWidget(widget);
                    controller.updateSelectIndex(0);
                  }
                  if (index == 1) {
                    Widget widget = NewWord();
                    controller.updateCurrentWidget(widget);
                    controller.updateSelectIndex(1);
                  }
                  if (index == 2) {
                    Widget widget = DevWord();
                    controller.updateCurrentWidget(widget);
                    controller.updateSelectIndex(2);
                  }
                  if (index == 3){
                    Widget widget = SettingsPage();
                    controller.updateCurrentWidget(widget);
                    controller.updateSelectIndex(3);
                  }
                }

               return Scaffold(
                  body: controller.getCurrentWidget,
                  bottomNavigationBar: BottomNavigationBar(
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: "翻译"),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.subscriptions),
                          label: "生词本",
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.rss_feed), label: '频道'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.school), label: '我的'),
                      ],
                      currentIndex: controller.currentSelectIndex,
                      fixedColor: Theme
                          .of(context)
                          .primaryColor,
                      onTap: _onItemTapped,
                      unselectedItemColor: const Color(0xff666666),
                      type: BottomNavigationBarType.fixed),
                );
              });
  }
}
