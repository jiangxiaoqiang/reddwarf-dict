import 'package:reddwarfdict/src/models/word/sentence.dart';

class WordTrans {
  WordTrans({
    required this.definition,
    required this.id,
    this.sentences
  });

  String definition;
  int id;
  List<Sentence>? sentences;
}
