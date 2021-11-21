import 'package:reddwarf_dict/models/request/sentence/sentence.dart';

class WordTrans {
  WordTrans({required this.definition, required this.id, required this.sentences});

  String definition;
  int id;
  List<Sentence> sentences;
}
