import 'package:reddwarf_dict/models/request/word/learning_word.dart';
import 'package:reddwarf_dict/models/request/word/word.dart';
import 'package:reddwarf_dict/networking/rest_api/word/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DevWordController extends GetxController {
  var isLoading = true.obs;
  var wordTrans = WordTrans(definition: "", id: 0).obs;
  var searchWord = "".obs;

  List<Card> _wordWidget = List.empty(growable: true);

  List<Card> get getCurrentRender => _wordWidget;

  @override
  void onInit() {
    renderWordCards();
    super.onInit();
  }

  Future<List<Card>> renderWordCards() async {
    List<LearningWord> words = await WordProvider.fetchLearningWord();
    List<Card> cards = List.empty(growable: true);
    for (var element in words) {
      var card = Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text(element.word),
              subtitle: Text(element.translation),
            )
          ],
        ),
      );
      cards.add(card);
    }
    _wordWidget = cards;
    update();
    return Future.value(cards);
  }

  void updateWords(String word) async {
    searchWord(word);
  }

  void fetchSearchResult() async {
    isLoading(true);
    try {
      if (searchWord.value.isEmpty) {
        return;
      }
      var result = await WordProvider.doSearch(searchWord.value);
      wordTrans(result);
    } finally {
      isLoading(false);
    }
  }

  void addLearningWord(String word) async {
    isLoading(true);
    try {
      if (wordTrans.value.id <= 0) {
        return;
      }
      WordProvider.addLearningWord(wordTrans.value.id,word);
    } finally {
      isLoading(false);
    }
  }
}
