// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sentence _$SentenceFromJson(Map<String, dynamic> json) => Sentence(
      sentence_zh: json['sentence_zh'] as String,
      id: json['id'] as int,
      word_id: json['word_id'] as int,
      sentence_en: json['sentence_en'] as String,
    );

Map<String, dynamic> _$SentenceToJson(Sentence instance) =>
    <String, dynamic>{
      'sentence_en': instance.sentence_en,
      'id': instance.id,
      'word_id': instance.word_id,
      'sentence_zh': instance.sentence_zh,
    };
