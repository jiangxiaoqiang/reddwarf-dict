import 'package:json_annotation/json_annotation.dart';

part 'sentence.g.dart';

@JsonSerializable()
class Sentence {
  Sentence({
     required this.sentence_zh,
     required this.id,
     required this.word_id,
     required this.sentence_en
  });

  String sentence_zh;
  int id;
  int word_id;
  String sentence_en;

  Map<String, dynamic> toJson() => _$SentenceToJson(this);

  factory Sentence.fromJson(Map<String, dynamic> json) {
    Sentence learningWord = _$SentenceFromJson(json);
    return learningWord;
  }
}
