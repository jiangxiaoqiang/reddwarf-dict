import 'dart:collection';
import 'package:get/get.dart' show GetConnect;
import 'package:reddwarfdict/src/models/word/word.dart';
import 'package:wheel/wheel.dart' show RestClient;

class WordProvider extends GetConnect {
  static Future<WordTrans?> doSearch(String word) async {
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("word", () => word);
    var response = await RestClient.postHttp("/dict/word/search/v1", wordRequest);
    if (RestClient.respSuccess(response)) {
      var result = response.data["result"];
      WordTrans wordTrans = WordTrans(difinition: result[0]["translation"]);
      return wordTrans;
    }
    return null;
  }

  static Future<WordTrans?> addLearningWord(String word) async {
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("word", () => word);
    var response = await RestClient.postHttp("/dict/word/learn/v1/add", wordRequest);
    if (RestClient.respSuccess(response)) {
      var result = response.data["result"];
      WordTrans wordTrans = WordTrans(difinition: result[0]["translation"]);
      return wordTrans;
    }
    return null;
  }
}
