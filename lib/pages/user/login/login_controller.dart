import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = true.obs;
  var submitting = false.obs;
  var userName = "".obs;
  var password = "".obs;
  var showPassword = false.obs;

}
