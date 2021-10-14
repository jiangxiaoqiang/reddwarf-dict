import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reddwarfdict/src/pages/home/home.dart';

class NavController extends GetxController {
  int _selectNavIndex = 0;
  var isLoading = true.obs;

  int get currentSelectIndex => _selectNavIndex;

  Widget _widget = Home();

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
