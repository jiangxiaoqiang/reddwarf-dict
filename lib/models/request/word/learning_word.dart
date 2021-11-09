
import 'package:json_annotation/json_annotation.dart';

part 'learning_word.g.dart';

@JsonSerializable()
class LearningWord {
  LearningWord({
     this.definition,
     this.id,
     this.word,
     this.translation,
     this.createdTime
  });

  String definition;
  int id;
  String word;
  String translation;
  int createdTime;

  Map<String, dynamic> toJson() => _$LearningWordToJson(this);

  factory LearningWord.fromJson(Map<String, dynamic> json) {
    LearningWord learningWord = _$LearningWordFromJson(json);
    return learningWord;
  }
}
