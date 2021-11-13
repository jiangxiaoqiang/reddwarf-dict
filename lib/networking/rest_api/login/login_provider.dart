import 'package:reddwarf_dict/models/login/cellphone_existence_check.dart';
import 'dart:async';
import 'package:async/async.dart';

class LoginApi {
  static Future<Result<CellphoneExistenceCheck>> checkPhoneExist(
      String phone, String countryCode) async {
    return Result.value(null);
  }
}
