import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_word_controller.dart';

class NewWord extends StatelessWidget {
  NewWord({Key key}) : super(key: key);

  List tabs = ["新闻", "历史", "图片"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewWordController>(
        init: NewWordController(),
        builder: (controller) {
          return DefaultTabController(
            length: tabs.length,
              child:Scaffold(
              body: SafeArea(
            child:TabBarView(
                children: tabs.map((e){
                    return ListView(
                      children:controller.getCurrentRender
                  );
                  }).toList(),
                ),
            )),
          );
        });
  }
}
