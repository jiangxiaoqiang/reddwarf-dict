import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddwarfdict/src/models/word/learning_word.dart';
import 'package:reddwarfdict/src/models/word/word.dart';
import 'package:reddwarfdict/src/service/word/word_provider.dart';

class NewWordController extends GetxController {
  var isLoading = true.obs;
  var wordTrans = WordTrans(definition: "", id: 0).obs;
  var searchWord = "".obs;

  late List<Card> _wordWidget = List.empty(growable: true);

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

  void addLearningWord() async {
    isLoading(true);
    try {
      if (wordTrans.value.id <= 0) {
        return;
      }
      WordProvider.addLearningWord(wordTrans.value.id);
    } finally {
      isLoading(false);
    }
  }
}
