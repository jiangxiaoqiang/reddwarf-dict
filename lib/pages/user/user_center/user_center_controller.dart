import 'package:reddwarf_dict/includes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wheel/wheel.dart';

class UserCenterController extends GetxController {
  int _selectNavIndex = 0;
  var isLoading = true.obs;
  var submitting = false.obs;

  int get currentSelectIndex => _selectNavIndex;

  Widget _widget = HomePage();

  Widget get getCurrentWidget => _widget;

  void updateCurrentWidget(Widget widget) {
    _widget = widget;
    update();
  }

  void updateSelectIndex(int index) {
    _selectNavIndex = index;
    update();
  }

  void fetchSearchResult() async {
    isLoading(true);
    try {} finally {
      isLoading(false);
    }
  }
}
