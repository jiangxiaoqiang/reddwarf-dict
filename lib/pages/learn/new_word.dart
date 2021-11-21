import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_word_controller.dart';

class NewWord extends StatelessWidget {
  NewWord({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewWordController>(
        init: NewWordController(),
        builder: (controller) {
          return Scaffold(
              body: SafeArea(
            child: ListView(
              children: controller.getCurrentRender,
            ),
          ));
        });
  }
}
