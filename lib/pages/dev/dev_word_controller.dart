import 'package:flutter_slidable/flutter_slidable.dart';
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

  DevWordController(TabController _tabController){
    _tabController.addListener(() {
      // https://stackoverflow.com/questions/60252355/tabcontroller-listener-called-multiple-times-how-does-indexischanging-work
      if (!_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            renderWordCards(_tabController.index );
            break;
          case 1:
            renderWordCards(_tabController.index);
            break;
          case 2:
            renderWordCards(_tabController.index);
            break;
        }
      }
    });
  }


  List<Card> get getCurrentRender => _wordWidget;

  @override
  void onInit() {
    renderWordCards(0);

    super.onInit();
  }

   Future<List<Card>> renderWordCards(int tabName) async {
    List<LearningWord> words = await WordProvider.fetchLearningWord(tabName);
    List<Card> cards = List.empty(growable: true);
    for (var element in words) {
      var card = Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Slidable(
            actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        actions:<Widget> [
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () async => {
             if(await WordProvider.updateLearningWord(element, 1)){
                renderWordCards(0)
             }
              }
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () => {
            },
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'More',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => {},
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => {

            },
          ),
        ],
        child: ListTile(
              title: Text(element.word),
              subtitle: Text(element.translation),
            )
            )],
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
      var result = await WordProvider.doTranslate(searchWord.value);
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
