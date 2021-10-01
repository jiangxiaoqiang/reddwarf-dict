import 'package:get/get.dart';
import 'package:reddwarfdict/src/models/word/word.dart';
import 'package:reddwarfdict/src/service/word/word_provider.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var wordTrans = WordTrans(difinition: "1").obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchSearchResult() async {
    isLoading(true);
    try {
      var result = await WordProvider.doSearch();
      wordTrans(result);
    } finally {
      isLoading(false);
    }
  }
}
