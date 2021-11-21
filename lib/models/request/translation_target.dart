class TranslationTarget {
  String id;
  String sourceLanguage;
  String targetLanguage;

  TranslationTarget({
     required this.id,
     required this.sourceLanguage,
     required this.targetLanguage,
  });

  factory TranslationTarget.fromJson(Map<String, dynamic> json) {
    return TranslationTarget(
      id: json['id'],
      sourceLanguage: json['sourceLanguage'],
      targetLanguage: json['targetLanguage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sourceLanguage': sourceLanguage,
      'targetLanguage': targetLanguage,
    };
  }
}
