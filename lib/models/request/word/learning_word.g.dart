// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningWord _$LearningWordFromJson(Map<String, dynamic> json) => LearningWord(
      definition: json['definition'] as String,
      id: json['id'] as int,
      word: json['word'] as String,
      translation: json['translation'] as String,
      createdTime: json['createdTime'] as int,
    );

Map<String, dynamic> _$LearningWordToJson(LearningWord instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'id': instance.id,
      'word': instance.word,
      'translation': instance.translation,
      'createdTime': instance.createdTime
    };
