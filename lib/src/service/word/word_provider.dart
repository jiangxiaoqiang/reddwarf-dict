import 'dart:collection';
import 'package:get/get.dart' show GetConnect;
import 'package:reddwarfdict/src/models/word/word.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, GlobalConfig, RestApiError, RestClient;

class WordProvider extends GetConnect {
  static Future<WordTrans?> doSearch() async {
    Map wordRequst = HashMap();
    wordRequst.putIfAbsent("word", () => "hello");
    var response = await RestClient.postHttp("/dict/word/search/v1", wordRequst);
    if (RestClient.respSuccess(response)) {
      var result = response.data["result"];
      WordTrans wordTrans = WordTrans(difinition: result[0]["word"]);
      return wordTrans;
    }
    return null;
  }
}
