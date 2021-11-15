import 'package:get/get.dart';
import 'package:wheel/wheel.dart';

class LoginController extends GetxController {
  var isLoading = true.obs;
  var submitting = false.obs;
  var userName = "".obs;
  var password = "".obs;
  var focused = "".obs;
  var showPassword = false.obs;
  var selectRegion ;

  RegionFlag _regionFlag = RegionFlag(
      code: "CN",
      emoji: "🇨🇳",
      unicode: "U+1F1E8 U+1F1F3",
      name:"China",
      dialCode: "+86"
  );

  RegionFlag get getDefaultRegionFlag => _regionFlag;

  void updateCurrentFlag(RegionFlag regionFlag) {
    _regionFlag = regionFlag;
    update();
  }
}
