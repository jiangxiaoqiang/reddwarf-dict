import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddwarfdict/src/models/word/sentence.dart';
import 'package:reddwarfdict/src/models/word/word.dart';
import 'package:reddwarfdict/src/service/word/word_provider.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var wordTrans = WordTrans(definition: "", id: 0,sentences: List.empty()).obs;
  var searchWord = "".obs;
  late List<Card> _wordWidget = List.empty(growable: true);
  List<Card> get getCurrentRender => _wordWidget;
  //WordTrans get getWordTrans => _wordTrans;

  @override
  void onInit() {
    super.onInit();
  }

  void updateWords(String word) async {
    searchWord(word);
  }

  Future<List<Card>> renderWordCards() async {
    List<Sentence>? words = wordTrans.value.sentences;
    if(words == null||words.isEmpty){
      return List.empty();
    }
    List<Card> cards = List.empty(growable: true);
    for (var element in words) {
      var card = Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text(element.sentence_en),
              subtitle: Text(element.sentence_zh),
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

  void fetchSearchResult() async {
    isLoading(true);
    try {
      if(searchWord.value.isEmpty){
        return;
      }
      var result = await WordProvider.doSearch(searchWord.value);
      wordTrans(result);
      renderWordCards();
    } finally {
      isLoading(false);
    }
  }

  void addLearningWord() async {
    isLoading(true);
    try {
      if(wordTrans.value.id<=0){
        return;
      }
     WordProvider.addLearningWord(wordTrans.value.id);
    } finally {
      isLoading(false);
    }
  }
}
