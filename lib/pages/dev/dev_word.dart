import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'dev_word_controller.dart';

class DevWord extends StatefulWidget {
  DevWord({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabControllerStuState();
  }
}

class _TabControllerStuState extends State<DevWord> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ["生词", "已记住", "全部"];

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DevWordController>(
        init: DevWordController(_tabController),
        builder: (controller) {
          Widget renderWordList(){
            return ListView(children: controller.getCurrentRender);
          }

          return Scaffold(
            appBar: AppBar(
                foregroundColor: Colors.red,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(1),
                    child: Material(
                        color: Colors.green,
                        child: TabBar(
                            indicatorColor: Colors.black,
                            labelColor: Colors.white,
                            controller: _tabController,
                            unselectedLabelColor: Colors.yellow,
                            tabs: tabs.map((e) => Tab(text: e)).toList())))),
            body: SafeArea(
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: tabs.map((e) {
                  return renderWordList();
                }).toList(),
              ),
            ),
          );
        });
  }
}
