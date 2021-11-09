import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dev_word_controller.dart';

class DevWord extends StatelessWidget {
  DevWord({Key key}) : super(key: key);

  List tabs = ["生词", "已记住", "全部"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DevWordController>(
        init: DevWordController(),
        builder: (controller) {
          return DefaultTabController(
            length: tabs.length,
            child: Scaffold(
                appBar: AppBar(
                    foregroundColor: Colors.red,
                    bottom:PreferredSize( 
                      preferredSize: Size.fromHeight(1),
                        child:Material(
                          color: Colors.green,
                        child:TabBar(
                            indicatorColor: Colors.black,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.yellow,
                            tabs: tabs.map((e) => Tab(text: e)).toList())))),
                body: SafeArea(
                  child: TabBarView(
                    children: tabs.map((e) {
                      return ListView(children: controller.getCurrentRender);
                    }).toList(),
                  ),
                )),
          );
        });
  }
}
