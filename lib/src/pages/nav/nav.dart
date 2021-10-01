import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'nav_controller.dart';

class Nav extends StatelessWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
        init: NavController(),
        builder: (controller) {
          void _onItemTapped(int index) {}
          return Scaffold(
            body: Text("d"),
            bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "ranslate"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.subscriptions),
                      label: "b",),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.rss_feed), label: '频道'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.school), label: '我的'),
                ],
                currentIndex: 1,
                fixedColor: Theme.of(context).primaryColor,
                onTap: _onItemTapped,
                unselectedItemColor: Color(0xff666666),
                type: BottomNavigationBarType.fixed),
          );
        });
  }
}
