import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'home_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController _controller = Get.put(HomeController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                TextField(
                  autofocus: false,
                  controller: _textController,
                  onChanged:  (v) {
                    print("onChange: $v");
                    _controller.updateWords(v);
                  },
                ),
                Obx(() => Text(controller.wordTrans.value.definition)),
                ElevatedButton(
                  onPressed: () {
                    _controller.fetchSearchResult();
                  },
                  child: Text("查询"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.addLearningWord();
                  },
                  child: Text("加入生词本"),
                )
              ],
            )),
          );
        });
  }
}
