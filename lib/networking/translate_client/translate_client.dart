export 'package:uni_translate/uni_translate.dart';
import 'package:uni_translate/uni_translate.dart';

import '../../includes.dart';
import 'pro_translation_engine.dart';

const kSupportedEngineTypes = [
  kEngineTypeBaidu,
  kEngineTypeCaiyun,
  kEngineTypeDeepL,
  kEngineTypeGoogle,
  kEngineTypeIciba,
  kEngineTypeSogou,
  kEngineTypeTencent,
  kEngineTypeYoudao,
  kEngineTypeReddwarf
];

final Map<String, List<String>> kKnownSupportedEngineOptionKeys = {
  kEngineTypeBaidu: BaiduTranslationEngine.optionKeys,
  kEngineTypeCaiyun: CaiyunTranslationEngine.optionKeys,
  kEngineTypeDeepL: DeepLTranslationEngine.optionKeys,
  kEngineTypeGoogle: GoogleTranslationEngine.optionKeys,
  kEngineTypeIciba: IcibaTranslationEngine.optionKeys,
  kEngineTypeSogou: SogouTranslationEngine.optionKeys,
  kEngineTypeTencent: TencentTranslationEngine.optionKeys,
  kEngineTypeYoudao: YoudaoTranslationEngine.optionKeys,
  kEngineTypeReddwarf: YoudaoTranslationEngine.optionKeys,
};

TranslationEngine createTranslationEngine(
  TranslationEngineConfig engineConfig,
) {
  TranslationEngine translationEngine = ReddwarfTranslationEngine(engineConfig);
  if (sharedLocalDb.proEngine(engineConfig.identifier).exists()) {
    translationEngine = ProTranslationEngine(engineConfig);
  } else {
    switch (engineConfig.type) {
      case kEngineTypeBaidu:
        translationEngine = BaiduTranslationEngine(engineConfig);
        break;
      case kEngineTypeCaiyun:
        translationEngine = CaiyunTranslationEngine(engineConfig);
        break;
      case kEngineTypeDeepL:
        translationEngine = DeepLTranslationEngine(engineConfig);
        break;
      case kEngineTypeGoogle:
        translationEngine = GoogleTranslationEngine(engineConfig);
        break;
      case kEngineTypeIciba:
        translationEngine = IcibaTranslationEngine(engineConfig);
        break;
      case kEngineTypeSogou:
        translationEngine = SogouTranslationEngine(engineConfig);
        break;
      case kEngineTypeTencent:
        translationEngine = TencentTranslationEngine(engineConfig);
        break;
      case kEngineTypeYoudao:
        translationEngine = YoudaoTranslationEngine(engineConfig);
        break;
      case kEngineTypeReddwarf:
        translationEngine = ReddwarfTranslationEngine(engineConfig);
        break;
    }
  }
  return translationEngine;
}

class AutoloadTranslateClientAdapter extends UniTranslateClientAdapter {
  Map<String, TranslationEngine> _translationEngineMap = {};

  @override
  TranslationEngine get first {
    TranslationEngineConfig engineConfig = sharedLocalDb.engines.list(where: (TranslationEngineConfig element) {
      return true;
    }).first;

    return use(engineConfig.identifier);
  }

  @override
  TranslationEngine use(String identifier) {
    TranslationEngineConfig engineConfig =
        sharedLocalDb.engine(identifier).get();
    TranslationEngine? translationEngine = _translationEngineMap[identifier];
    if (translationEngine == null) {
      translationEngine = createTranslationEngine(engineConfig);
      if (translationEngine != null) {
        _translationEngineMap.update(
          engineConfig.identifier,
          (_) => translationEngine!,
          ifAbsent: () => translationEngine!,
        );
      }
    }
    return _translationEngineMap[identifier]!;
  }
}

UniTranslateClient sharedTranslateClient =
    UniTranslateClient(AutoloadTranslateClientAdapter());
