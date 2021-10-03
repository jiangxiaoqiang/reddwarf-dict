import 'package:get/get.dart';
import 'package:reddwarfdict/src/models/word/word.dart';
import 'package:reddwarfdict/src/service/word/word_provider.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var wordTrans = WordTrans(difinition: "1").obs;
  var searchWord = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateWords(String word) async {
    searchWord(word);
  }

  void fetchSearchResult() async {
    isLoading(true);
    try {
      if(searchWord.value.isEmpty){
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
      if(searchWord.value.isEmpty){
        return;
      }
      var result = await WordProvider.addLearningWord(searchWord.value);
    } finally {
      isLoading(false);
    }
  }
}
