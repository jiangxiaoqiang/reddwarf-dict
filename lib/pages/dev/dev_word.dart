import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dev_word_controller.dart';

class DevWord extends StatelessWidget {
  DevWord({Key key}) : super(key: key);

  List tabs = ["新闻", "历史", "图片"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DevWordController>(
        init: DevWordController(),
        builder: (controller) {
          return DefaultTabController(
            length: tabs.length,
            child: Scaffold(
                appBar: AppBar(toolbarHeight: 3,
                    foregroundColor: Colors.red,
                    bottom: TabBar(tabs: tabs.map((e) => Tab(text: e)).toList())),
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
