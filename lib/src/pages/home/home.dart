import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'home_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController _controller = Get.put(HomeController());
  TextEditingController _textController = TextEditingController();

  void initState() {
    _textController.addListener(() {
      print(_textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                TextField(),
                Obx(() => Text(controller.wordTrans.value.difinition)),
                ElevatedButton(
                  onPressed: () {
                    _controller.fetchSearchResult();
                  },
                  child: Text("查询"),
                )
              ],
            )),
          );
        });
  }
}
