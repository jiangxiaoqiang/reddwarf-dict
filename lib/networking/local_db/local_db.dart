import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../includes.dart';
import 'modifiers/engines_modifier.dart';
import 'modifiers/ocr_engines_modifier.dart';
import 'modifiers/preferences_modifier.dart';
import 'modifiers/translation_targets_modifier.dart';

export 'modifiers/engines_modifier.dart';
export 'modifiers/ocr_engines_modifier.dart';
export 'modifiers/preferences_modifier.dart';
export 'modifiers/private_engines_modifier.dart';
export 'modifiers/private_ocr_engines_modifier.dart';
export 'modifiers/pro_engines_modifier.dart';
export 'modifiers/pro_ocr_engines_modifier.dart';
export 'modifiers/translation_targets_modifier.dart';

const _kLocalUser = -1;

class _ListenerEntry extends LinkedListEntry<_ListenerEntry> {
  _ListenerEntry(this.listener);

  final VoidCallback listener;
}

class _ConfigChangeNotifier implements Listenable {
  LinkedList<_ListenerEntry> _listeners = LinkedList<_ListenerEntry>();

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_listeners == null) {
        throw FlutterError('A $runtimeType was used after being disposed.\n'
            'Once you have called dispose() on a $runtimeType, it can no longer be used.');
      }
      return true;
    }());
    return true;
  }

  @protected
  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _listeners.isNotEmpty;
  }

  @override
  void addListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    _listeners.add(_ListenerEntry(listener));
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    for (final _ListenerEntry entry in _listeners) {
      if (entry.listener == listener) {
        entry.unlink();
        return;
      }
    }
  }

  @mustCallSuper
  void dispose() {
    assert(_debugAssertNotDisposed());
    _listeners = List.empty() as LinkedList<_ListenerEntry>;
  }

  @protected
  @visibleForTesting
  void notifyListeners() {
    assert(_debugAssertNotDisposed());
    if (_listeners.isEmpty) return;

    final List<_ListenerEntry> localListeners = List<_ListenerEntry>.from(_listeners);

    for (final _ListenerEntry entry in localListeners) {
      try {
        if (entry.list != null) entry.listener();
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
        ));
      }
    }
  }
}

class LocalDb extends _ConfigChangeNotifier {
  final DbData defaultDbData;

  LocalDb({
    required this.defaultDbData,
  });

  DbData? dbData;

  ProEnginesModifier? _proEnginesModifier;
  ProOcrEnginesModifier? _proOcrEnginesModifier;
  PrivateEnginesModifier? _privateEnginesModifier;
  PrivateOcrEnginesModifier? _privateOcrEnginesModifier;

  EnginesModifier? _enginesModifier;
  OcrEnginesModifier? _ocrEnginesModifier;
  PreferencesModifier? _preferencesModifier;
  TranslationTargetsModifier? _translationTargetsModifier;

  Future<File> get _localFile async {
    final appDir = await Config.instance.getAppDirectory();
    if (!appDir.existsSync()) {
      appDir.createSync(recursive: true);
    }
    return File('${appDir.path}/db.json');
  }

  Future<DbData?> read() async {
    this.dbData = defaultDbData;
    if (kIsWeb) {
      // TODO: Save to localStorage.
    } else {
      final file = await _localFile;
      if (file.existsSync()) {
        String jsonString = await file.readAsString();
        this.dbData = DbData.fromJson(json.decode(jsonString));
      }
    }

    notifyListeners();

    return this.dbData;
  }

  Future<void> write() async {
    notifyListeners();

    if (kIsWeb) return;

    final file = await _localFile;
    final String jsonString = prettyJsonString(
      this.dbData!.toJson().removeNulls(),
    );
    await file.writeAsString(jsonString);
  }

  Future<DbData?> loadFromProAccount() async {
    var oldProEngineList = this.dbData!.proEngineList ?? [];
    var oldProOcrEngineList = this.dbData!.proOcrEngineList ?? [];

    try {
      List<TranslationEngineConfig> newProEngineList = await proAccount.engines.list();
      this.dbData!.proEngineList = newProEngineList.map((engine) {
        var oldEngine = oldProEngineList.firstWhere(
          (e) => e.identifier == engine.identifier,
        );
        if (oldEngine != null) {
          engine.disabled = oldEngine.disabled;
        }
        return engine;
      }).toList();
    } catch (error) {}

    try {
      List<OcrEngineConfig> newProOcrEngineList = await proAccount.ocrEngines.list();
      this.dbData!.proOcrEngineList = newProOcrEngineList.map((engine) {
        var oldOrcEngine = oldProOcrEngineList.firstWhere(
          (e) => e.identifier == engine.identifier,
        );
        if (oldOrcEngine != null) {
          engine.disabled = oldOrcEngine.disabled;
        }
        return engine;
      }).toList();
    } catch (error) {}

    List<String> proEngineIdList = this.dbData!.proEngineList.map((e) => e.identifier).toList();
    if (sharedConfig.defaultEngineId == null || !proEngineIdList.contains(sharedConfig.defaultEngineId)) {
      sharedConfigManager.setDefaultEngineId(
        this.dbData!.proEngineList.firstWhere((e) => e.type == 'baidu').identifier,
      );
    }

    List<String> proOcrEngineIdList = this.dbData!.proOcrEngineList.map((e) => e.identifier).toList();
    if (sharedConfig.defaultOcrEngineId == null || !proOcrEngineIdList.contains(sharedConfig.defaultOcrEngineId)) {
      sharedConfigManager.setDefaultOcrEngineId(
        this.dbData!.proOcrEngineList.firstWhere((e) => e.type == 'built_in').identifier,
      );
    }
    await this.write();
    return this.dbData;
  }

  ProEnginesModifier get proEngines {
    return proEngine("");
  }

  ProEnginesModifier proEngine(String id) {
    if (_proEnginesModifier == null) {
      _proEnginesModifier = ProEnginesModifier(this.dbData!, "dbdata");
    }
    _proEnginesModifier!.setId(id);
    return _proEnginesModifier!;
  }

  ProOcrEnginesModifier get proOcrEngines {
    return proOcrEngine("");
  }

  ProOcrEnginesModifier proOcrEngine(String id) {
    if (_proOcrEnginesModifier == null) {
      _proOcrEnginesModifier = ProOcrEnginesModifier(this.dbData!, "");
    }
    _proOcrEnginesModifier!.setId(id);
    return _proOcrEnginesModifier!;
  }

  PrivateEnginesModifier get privateEngines {
    return privateEngine("");
  }

  PrivateEnginesModifier privateEngine(String id) {
    if (_privateEnginesModifier == null) {
      _privateEnginesModifier = PrivateEnginesModifier(this.dbData!, "");
    }
    _privateEnginesModifier!.setId(id);
    return _privateEnginesModifier!;
  }

  PrivateOcrEnginesModifier get privateOcrEngines {
    return privateOcrEngine("");
  }

  PrivateOcrEnginesModifier privateOcrEngine(String id) {
    if (_privateOcrEnginesModifier == null) {
      _privateOcrEnginesModifier = PrivateOcrEnginesModifier(this.dbData!, "");
    }
    _privateOcrEnginesModifier!.setId(id);
    return _privateOcrEnginesModifier!;
  }

  EnginesModifier get engines {
    return engine(null);
  }

  EnginesModifier engine(String? id) {
    if (_enginesModifier == null) {
      _enginesModifier = EnginesModifier(this.dbData!, id);
    }
    _enginesModifier!.setId(id);
    return _enginesModifier!;
  }

  OcrEnginesModifier get ocrEngines {
    return ocrEngine("");
  }

  OcrEnginesModifier ocrEngine(String id) {
    if (_ocrEnginesModifier == null) {
      _ocrEnginesModifier = OcrEnginesModifier(this.dbData!, "");
    }
    _ocrEnginesModifier!.setId(id);
    return _ocrEnginesModifier!;
  }

  PreferencesModifier get preferences {
    return preference("null");
  }

  PreferencesModifier preference(String key) {
    if (_preferencesModifier == null) {
      _preferencesModifier = PreferencesModifier(this.dbData!, "");
    }
    _preferencesModifier!.setKey(key);
    return _preferencesModifier!;
  }

  TranslationTargetsModifier get translationTargets {
    return translationTarget("");
  }

  TranslationTargetsModifier translationTarget(String id) {
    if (_translationTargetsModifier == null) {
      _translationTargetsModifier = TranslationTargetsModifier(this.dbData!, "");
    }
    _translationTargetsModifier!.setId(id);
    return _translationTargetsModifier!;
  }
}

class DbData {
  List<TranslationEngineConfig> proEngineList;
  List<OcrEngineConfig> proOcrEngineList;
  List<TranslationEngineConfig> privateEngineList;
  List<OcrEngineConfig> privateOcrEngineList;
  List<UserPreference> preferenceList;
  List<TranslationTarget> translationTargetList;

  List<TranslationEngineConfig> get engineList => []
    ..addAll(proEngineList ?? [])
    ..addAll(privateEngineList ?? []);

  List<OcrEngineConfig> get ocrEngineList => []
    ..addAll(proOcrEngineList ?? [])
    ..addAll(privateOcrEngineList ?? []);

  DbData({
    required this.proEngineList,
    required this.proOcrEngineList,
    required this.privateEngineList,
    required this.privateOcrEngineList,
    required this.preferenceList,
    required this.translationTargetList,
  });

  factory DbData.fromJson(Map<String, dynamic> json) {
    List<TranslationEngineConfig> proEngineList = [];
    List<OcrEngineConfig> proOcrEngineList = [];
    List<TranslationEngineConfig> privateEngineList = [];
    List<OcrEngineConfig> privateOcrEngineList = [];
    List<UserPreference> preferenceList = [];
    List<TranslationTarget> translationTargetList = [];

    if (json['proEngineList'] != null) {
      Iterable proEngineList = json['proEngineList'] as List;
      proEngineList = proEngineList
          .map((item) => TranslationEngineConfig.fromJson(item))
          .toList();
    }
    if (json['proOcrEngineList'] != null) {
      Iterable l = json['proOcrEngineList'] as List;
      proOcrEngineList = l.map((item) => OcrEngineConfig.fromJson(item)).toList();
    }
    if (json['privateEngineList'] != null) {
      Iterable privateEngineList = json['privateEngineList'] as List;
      privateEngineList = privateEngineList
          .map((item) => TranslationEngineConfig.fromJson(item))
          .toList();
    }
    if (json['privateOcrEngineList'] != null) {
      Iterable l = json['privateOcrEngineList'] as List;
      privateOcrEngineList = l.map((item) => OcrEngineConfig.fromJson(item)).toList();
    }
    if (json['preferenceList'] != null) {
      Iterable l = json['preferenceList'] as List;
      preferenceList = l.map((item) => UserPreference.fromJson(item)).toList();
    }
    if (json['translationTargetList'] != null) {
      Iterable l = json['translationTargetList'] as List;
      translationTargetList = l.map((item) => TranslationTarget.fromJson(item)).toList();
    }

    return DbData(
      proEngineList: proEngineList,
      proOcrEngineList: proOcrEngineList,
      privateEngineList: privateEngineList,
      privateOcrEngineList: privateOcrEngineList,
      preferenceList: preferenceList,
      translationTargetList: translationTargetList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'proEngineList': (proEngineList ?? []).map((e) => e.toJson()).toList(),
      'proOcrEngineList': (proOcrEngineList ?? []).map((e) => e.toJson()).toList(),
      'privateEngineList': (privateEngineList ?? []).map((e) => e.toJson()).toList(),
      'privateOcrEngineList': (privateOcrEngineList ?? []).map((e) => e.toJson()).toList(),
      'preferenceList': (preferenceList ?? []).map((e) => e.toJson()).toList(),
      'translationTargetList': (translationTargetList ?? []).map((e) => e.toJson()).toList(),
    };
  }
}

LocalDb sharedLocalDb = LocalDb(
  defaultDbData: DbData(
    privateEngineList: [],
    privateOcrEngineList: [],
    translationTargetList: [
      TranslationTarget(
        sourceLanguage: kLanguageEN,
        targetLanguage: kLanguageZH,
        id: '',
      ),
      TranslationTarget(
        sourceLanguage: kLanguageZH,
        targetLanguage: kLanguageEN,
        id: '',
      ),
    ],
    proEngineList: [],
    preferenceList: [],
    proOcrEngineList: [],
  ),
);

Future<void> initLocalDb() async {
  await sharedLocalDb.read();
  await addDefaultTranslateEngine();
}

/**
 * he default translate engine was set to red dwarf
 */
Future<void> addDefaultTranslateEngine() async{
  final id = sharedConfig.defaultEngineId;
  final type = "reddwarf";
  await sharedLocalDb.privateEngine(id).createDefaultTranslationEngine(
    type: type,
    option: Map(),
    disabledScopes: [],
    name: 'reddwarf',
    id: id
  );
  await sharedLocalDb.write();
}
