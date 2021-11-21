import 'package:flutter/material.dart';

const kPreferenceTypeInt = 'int';
const kPreferenceTypeBool = 'bool';

// 翻译
const kPrefTranslationMode = 'translation_mode';
const kPrefDefaultEngineId = 'default_engine_id';
// 取词
const kPrefUseLocalOcrEngine = 'use_local_ocr_engine';
const kPrefDefaultOcrEngineId = 'default_ocr_engine_id';
// 界面
const kPrefShowTrayIcon = 'show_tray_icon';
const kPrefTrayIconStyle = 'tray_icon_style';
const kPrefMaxWindowHeight = 'max_window_height';
// 显示语言
const kPrefAppLanguage = 'app_language';
// 主题模式
const kPrefThemeMode = 'theme_mode';
// 快捷键
const kPrefShortcutShowOrHide = 'shortcut_show_or_hide';
const kPrefShortcutExtractFromScreenCapture =
    'shortcut_extract_text_from_screen_capture';
const kPrefShortcutExtractFromScreenSelection =
    'shortcut_extract_text_from_screen_selection';
// 输入设置
const kPrefInputSetting = 'input_setting';

const kTranslationModeAuto = 'auto';
const kTranslationModeManual = 'manual';

const kTrayIconStyleWhite = 'white';
const kTrayIconStyleBlack = 'black';

const kInputSettingSubmitWithEnter = 'submit-with-enter';
const kInputSettingSubmitWithMetaEnter = 'submit-with-meta+enter';

const Map<String, ThemeMode> kKnownThemeModes = <String, ThemeMode>{
  'light': ThemeMode.light,
  'dark': ThemeMode.dark,
  'system': ThemeMode.system,
};

class UserPreference {
  String id;
  String key;
  String type;
  String value;
  String createdAt;
  String updatedAt;

  int get intValue {
    return int.parse(value);
  }

  bool get boolValue {
    return value == 'true';
  }

  UserPreference({
    required this.id,
    required this.key,
    required this.type,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPreference.fromJson(Map<String, dynamic> json) {
    return UserPreference(
      id: json['id'],
      key: json['key'],
      type: json['type'],
      value: json['value'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'type': type,
      'value': value,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
