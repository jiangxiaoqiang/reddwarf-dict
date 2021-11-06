import 'package:biyi_app/models/request/sentence/sentence.dart';

class WordTrans {
  WordTrans({
     this.definition,
     this.id,
    this.sentences
  });

  String definition;
  int id;
  List<Sentence> sentences;
}
