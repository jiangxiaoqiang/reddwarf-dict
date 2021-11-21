import 'package:uni_translate/uni_translate.dart';

class TranslationResultRecord {
  String id;
  String translationTargetId;
  String translationEngineId;
  LookUpRequest? lookUpRequest;
  LookUpResponse? lookUpResponse;
  UniTranslateClientError? lookUpError;
  TranslateRequest? translateRequest;
  TranslateResponse? translateResponse;
  UniTranslateClientError? translateError;

  TranslationResultRecord({
    required this.id,
    required this.translationTargetId,
    required this.translationEngineId,
     this.lookUpRequest,
     this.lookUpResponse,
     this.translateRequest,
     this.translateResponse,
  });

  factory TranslationResultRecord.fromJson(Map<String, dynamic> json) {
    return TranslationResultRecord(
      id: json['id'],
      translationTargetId: json['translationTargetId'],
      translationEngineId: json['translationEngineId'],
      lookUpRequest: LookUpRequest.fromJson(json['lookUpRequest']),
      lookUpResponse: LookUpResponse.fromJson(json['lookUpResponse']),
      translateRequest: TranslateRequest.fromJson(json['translateRequest']),
      translateResponse: TranslateResponse.fromJson(json['translateResponse']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'translationTargetId': translationTargetId,
      'translationEngineId': translationEngineId,
      'lookUpRequest': lookUpRequest?.toJson(),
      'lookUpResponse': lookUpResponse?.toJson(),
      'lookUpError': lookUpError?.toJson(),
      'translateRequest': translateRequest?.toJson(),
      'translateResponse': translateResponse?.toJson(),
      'translateError': translateError?.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}
