import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reddwarf_dict/models/request/sentence/sentence.dart';
import 'package:reddwarf_dict/models/request/word/learning_word.dart';
import 'package:reddwarf_dict/models/request/word/word.dart';
import 'package:wheel/wheel.dart' show RestClient;

class WordProvider {
  static Future<WordTrans> doTranslate(String word) async {
    WordTrans wordTransDefault = WordTrans(definition: 'No Result', id: 0, sentences: []);
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("word", () => word.toLowerCase().trim());
    var response = await RestClient.postHttp("/dict/word/translate/v1", wordRequest);
    if (RestClient.respSuccess(response)) {
      var result = response.data["result"];
      if (result.isNotEmpty) {
        var sentenceMap = result["sentences"] as List;
        List<Sentence> sList = List.empty(growable: true);
        if (sentenceMap.isNotEmpty) {
          sentenceMap.forEach((element) {
            Sentence sentence_entity = Sentence.fromJson(element);
            sList.add(sentence_entity);
          });
        }
        WordTrans wordTrans = WordTrans(definition: result["translation"], id: result["id"], sentences: sList);
        return wordTrans;
      } else {
        return wordTransDefault;
      }
    }
    return wordTransDefault;
  }

  static Future<List<LearningWord>> fetchGlossary(int tabName) async {
    Map<String,Object> params = HashMap();
    params.putIfAbsent("wordType", () => tabName);
    String path = "/dict/word/learn/v1/fetch?";
    final queryString = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    var response = await RestClient.getHttp(path + queryString);
    if (RestClient.respSuccess(response)) {
      var result = response.data["result"] as List;
      List<LearningWord> words = List.empty(growable: true);
      for (var element in result) {
        LearningWord learningWord = LearningWord.fromJson(element);
        words.add(learningWord);
      }
      if (words.length > 1) {
        words:
        words.sort((a, b) => b.createdTime.compareTo(a.createdTime));
      }
      return words;
    }
    return Future.value(List.empty());
  }

  static Future<bool> updateLearningWord(LearningWord word,int wordStatus) async {
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("word", () => word.word.trim());
    wordRequest.putIfAbsent("wordStatus", () => wordStatus);
    wordRequest.putIfAbsent("wordId", () => word.id);
    var response = await RestClient.putHttp("/dict/word/learn/v1/update", wordRequest);
    if (RestClient.respSuccess(response)) {
      return true;
    }
    return false;
  }

    static Future<void> addGlossary(int wordId, String word) async {
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("wordId", () => wordId);
    wordRequest.putIfAbsent("word", () => word.trim());
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
          msg: "加入失败",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
