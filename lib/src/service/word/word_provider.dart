import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' show GetConnect;
import 'package:reddwarfdict/src/models/word/learning_word.dart';
import 'package:reddwarfdict/src/models/word/word.dart';
import 'package:wheel/wheel.dart' show RestClient;

class WordProvider extends GetConnect {
  static Future<WordTrans?> doSearch(String word) async {
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("word", () => word.toLowerCase());
    var response = await RestClient.postHttp("/dict/word/search/v1", wordRequest);
    if (RestClient.respSuccess(response)) {
      var result = response.data["result"] as List;
      if (result.isNotEmpty) {
        WordTrans wordTrans = WordTrans(definition: result[0]["translation"], id: result[0]["id"]);
        return wordTrans;
      } else {
        WordTrans wordTrans = WordTrans(definition: 'No Result', id: 0);
        return wordTrans;
      }
    }
    return null;
  }

  static Future<List<LearningWord>> fetchLearningWord() async {
    Map wordRequest = HashMap();
    //var response = await RestClient.postHttp("/dict/word/learn/v1/fetch", wordRequest);
    //if (RestClient.respSuccess(response)) {}
    LearningWord learningWord = LearningWord(word: 'ad', id: 1, definition: 'dfwg');
    return Future.value(List.filled(1, learningWord, growable: false));
  }

  static Future<void> addLearningWord(int wordId) async {
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("word_id", () => wordId);
    var response = await RestClient.postHttp("/dict/word/learn/v1/add", wordRequest);
    if (RestClient.respSuccess(response)) {
      Fluttertoast.showToast(
          msg: "已加入生词本",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "加入失败", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
    }
  }
}
