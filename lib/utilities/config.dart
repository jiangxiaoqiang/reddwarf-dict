import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import '../includes.dart';

const kShortcutShowOrHide = 'shortcut_show_or_hide';
const kShortcutExtractFromScreenSelection =
    'shortcut_extract_from_screen_selection';
const kShortcutExtractFromScreenCapture =
    'shortcut_extract_from_screen_capture';
const kShortcutExtractFromClipboard = 'shortcut_extract_from_clipboard';

Future<void> initConfig() async {
  await ConfigManager.instance.reload();
}

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

  }

  @protected
  @visibleForTesting
  void notifyListeners() {
    assert(_debugAssertNotDisposed());
    if (_listeners.isEmpty) return;

    final List<_ListenerEntry> localListeners =
        List<_ListenerEntry>.from(_listeners);

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

class Config {
  Config._();

  /// The shared instance of [Config].
  static final Config instance = Config._();

  Future<Directory> getAppDirectory() async {
    return proAccount.dataDirectory!;
  }

  String? translationMode;
  String defaultEngineId ="default_engine_id";
  bool? useLocalOcrEngine;
  String? defaultOcrEngineId;
  bool? showTrayIcon;
  String? trayIconStyle;
  double? maxWindowHeight;
  String? appLanguage;
  ThemeMode? themeMode;
  String? inputSetting;
  HotKey? shortcutShowOrHide;
  HotKey? shortcutExtractFromScreenSelection;
  HotKey? shortcutExtractFromScreenCapture;
  HotKey? shortcutExtractFromClipboard;
  HotKey get shortcutInputSettingSubmitWithMetaEnter {
    if (kIsMacOS) {
      return HotKey(
        KeyCode.enter,
        modifiers: [KeyModifier.meta],
        scope: HotKeyScope.inapp,
      );
    }
    return HotKey(
      KeyCode.enter,
      modifiers: [KeyModifier.control],
      scope: HotKeyScope.inapp,
    );
  }
}

class ConfigManager extends _ConfigChangeNotifier {
  ConfigManager._();

  /// The shared instance of [ConfigManager].
  static final ConfigManager instance = ConfigManager._();

  Config getConfig() => Config.instance;

  Future<void> reload() async {
    Config.instance.translationMode = await _getString(
      kPrefTranslationMode,
      defaultValue: kTranslationModeManual,
    );
    Config.instance.defaultEngineId = (await _getString(
      kPrefDefaultEngineId, defaultValue: kPrefDefaultEngineId
    ))!;
    Config.instance.useLocalOcrEngine = await _getBool(
      kPrefUseLocalOcrEngine,
      defaultValue: false,
    );
    Config.instance.defaultOcrEngineId = await _getString(
      kPrefDefaultOcrEngineId,
    );
    Config.instance.showTrayIcon = await _getBool(
      kPrefShowTrayIcon,
      defaultValue: true,
    );
    Config.instance.trayIconStyle = await _getString(
      kPrefTrayIconStyle,
      defaultValue: kIsWindows ? kTrayIconStyleBlack : kTrayIconStyleWhite,
    );
    String? max = await _getString(
      kPrefMaxWindowHeight,
      defaultValue: '600',
    );
    Config.instance.maxWindowHeight = double.parse(max!);
    Config.instance.appLanguage = await _getString(
      kPrefAppLanguage,
      defaultValue: kLanguageZH,
    );
    String? _themeModeString = await _getString(
      kPrefThemeMode,
      defaultValue: describeEnum(ThemeMode.light),
    );
    Config.instance.themeMode = kKnownThemeModes[_themeModeString];
    Config.instance.inputSetting = await _getString(
      kPrefInputSetting,
      defaultValue: kInputSettingSubmitWithEnter,
    );
    Config.instance.shortcutShowOrHide = await getShortcut(
      kShortcutShowOrHide,
      defaultValue: HotKey(
        KeyCode.digit1,
        modifiers: [KeyModifier.alt],
        identifier: kShortcutShowOrHide,
      ),
    );
    Config.instance.shortcutExtractFromScreenSelection = await getShortcut(
      kShortcutExtractFromScreenSelection,
      defaultValue: HotKey(
        KeyCode.keyQ,
        modifiers: [KeyModifier.alt],
        identifier: kShortcutExtractFromScreenSelection,
      ),
    );
    Config.instance.shortcutExtractFromScreenCapture = await getShortcut(
      kShortcutExtractFromScreenCapture,
      defaultValue: HotKey(
        KeyCode.keyW,
        modifiers: [KeyModifier.alt],
        identifier: kShortcutExtractFromScreenCapture,
      ),
    );
    Config.instance.shortcutExtractFromClipboard = await getShortcut(
      kShortcutExtractFromClipboard,
      defaultValue: HotKey(
        KeyCode.keyE,
        modifiers: [KeyModifier.alt],
        identifier: kShortcutExtractFromClipboard,
      ),
    );
  }

  Future<void> setTranslationMode(String value) {
    return _setString(kPrefTranslationMode, value);
  }

  Future<void> setDefaultEngineId(String value) {
    return _setString(kPrefDefaultEngineId, value);
  }

  Future<void> setUseLocalOcrEngine(bool value) {
    return _setBool(kPrefUseLocalOcrEngine, value);
  }

  Future<void> setDefaultOcrEngineId(String value) {
    return _setString(kPrefDefaultOcrEngineId, value);
  }

  Future<void> setShowTrayIcon(bool value) {
    return _setBool(kPrefShowTrayIcon, value);
  }

  Future<void> setTrayIconStyle(String value) {
    return _setString(kPrefTrayIconStyle, value);
  }

  Future<void> setMaxWindowHeight(double value) {
    return _setString(kPrefMaxWindowHeight, value.toString());
  }

  Future<void> setAppLanguage(String value) {
    return _setString(kPrefAppLanguage, value);
  }

  Future<void> setThemeMode(ThemeMode value) {
    return _setString(kPrefThemeMode, describeEnum(value));
  }

  Future<void> setInputSetting(String value) {
    return _setString(kPrefInputSetting, value);
  }

  Future<void> setShortcut(String key, HotKey hotKey) async {
    return _setString(
      key,
      json.encode(hotKey.toJson()),
    );
  }

  Future<HotKey?> getShortcut(String key, {HotKey? defaultValue}) async {
    HotKey hotKey = new HotKey(KeyCode.keyC);
    String? jsonString = await _getString(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      hotKey = HotKey.fromJson(json.decode(jsonString));
    }
    return hotKey ?? defaultValue;
  }

  Future<void> _setString(String key, String value) async {
    UserPreference? pref = sharedLocalDb.preference(key).get();
    if (pref == null) {
      sharedLocalDb.preferences.create(key: key, value: value, type: '');
    } else {
      sharedLocalDb.preference(key).update(value: value, type: '');
    }

    sharedLocalDb.write();

    await reload();
    notifyListeners();
  }

  Future<String?> _getString(String key, {String? defaultValue}) async {
    UserPreference? pref = sharedLocalDb.preference(key).get();
    return pref?.value ?? defaultValue;
  }

  Future<void> _setBool(String key, bool value) async {
    UserPreference? pref = sharedLocalDb.preference(key).get();
    if (pref == null) {
      sharedLocalDb.preferences.create(
        key: key,
        type: kPreferenceTypeBool,
        value: '$value',
      );
    } else {
      sharedLocalDb.preference(key).update(
            type: kPreferenceTypeBool,
            value: '$value',
          );
    }

    sharedLocalDb.write();

    await reload();
    notifyListeners();
  }

  Future<bool?> _getBool(String key, {bool? defaultValue}) async {
    UserPreference? pref = sharedLocalDb.preference(key).get();
    return pref?.boolValue ?? defaultValue;
  }
}
