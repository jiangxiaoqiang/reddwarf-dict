import 'dart:collection';

import 'package:biyi_app/models/request/sentence/sentence.dart';
import 'package:biyi_app/models/request/word/learning_word.dart';
import 'package:biyi_app/models/request/word/word.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wheel/wheel.dart' show RestClient;

class WordProvider {
  static Future<WordTrans> doSearch(String word) async {
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("word", () => word.toLowerCase().trim());
    var response = await RestClient.postHttp("/dict/word/translate/v1", wordRequest);
    if (RestClient.respSuccess(response)) {
      var result = response.data["result"];
      if (result.isNotEmpty) {
        var sentenceMap = result["sentences"] as List;
        List<Sentence> sList = List.empty(growable: true);
        if(sentenceMap.isNotEmpty){
          sentenceMap.forEach((element) {
            Sentence sentence_entity = Sentence.fromJson(element);
            sList.add(sentence_entity);
          });
        }
        WordTrans wordTrans = WordTrans(
            definition: result["translation"],
            id: result["id"],
            sentences: sList
        );
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
    wordRequest.putIfAbsent("word_id", () => 1);
    var response = await RestClient.postHttp("/dict/word/learn/v1/fetch", wordRequest);
    if (RestClient.respSuccess(response)) {
      var result = response.data["result"] as List;
      List<LearningWord> words = List.empty(growable: true);
      for (var element in result) {
        LearningWord learningWord = LearningWord.fromJson(element);
        words.add(learningWord);
      }
      return words;
    }
    return Future.value(List.empty());
  }

  static Future<void> addLearningWord(int wordId,String word) async {
    Map wordRequest = HashMap();
    wordRequest.putIfAbsent("word_id", () => wordId);
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
