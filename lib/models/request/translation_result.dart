import './translation_result_record.dart';
import './translation_target.dart';

class TranslationResult {
  String id;
  TranslationTarget translationTarget;
  List<TranslationResultRecord> translationResultRecordList;
  List<String> unsupportedEngineIdList;

  TranslationResult({
     this.id,
     this.translationTarget,
     this.translationResultRecordList,
     this.unsupportedEngineIdList,
  });

  factory TranslationResult.fromJson(Map<String, dynamic> json) {

    List<TranslationResultRecord> translationResultRecordList = [];

    if (json['translationResultRecordList'] != null) {
      translationResultRecordList =
          (json['translationResultRecordList'] as List)
              .map((item) => TranslationResultRecord.fromJson(item))
              .toList();
    }

    return TranslationResult(
      id: json['id'],
      translationTarget: TranslationTarget.fromJson(json['translationTarget']),
      translationResultRecordList: translationResultRecordList,
      unsupportedEngineIdList: List<String>.from(
        json['unsupportedEngineIdList'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'translationTarget': translationTarget,
      'translationResultRecordList':
          translationResultRecordList?.map((e) => e.toJson())?.toList(),
      'unsupportedEngineIdList': unsupportedEngineIdList,
    };
  }
}
