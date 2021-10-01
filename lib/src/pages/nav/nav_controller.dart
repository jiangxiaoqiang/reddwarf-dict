import 'package:get/get.dart';

class NavController extends GetxController {
  bool _showDebug = false;
  var isLoading = true.obs;
  bool get showDebug => _showDebug;
  void increment() {
    _showDebug = !_showDebug;
    update();
  }

  void fetchSearchResult() async {
    isLoading(true);
    try {
    } finally {
      isLoading(false);
    }
  }
}
