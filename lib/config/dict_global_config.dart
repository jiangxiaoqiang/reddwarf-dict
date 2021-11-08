import 'dart:async';

import 'package:reddwarf_dict/navigators/app_navigator.dart';
import 'package:reddwarf_dict/networking/local_db/local_db.dart';
import 'package:reddwarf_dict/utilities/config.dart';
import 'package:reddwarf_dict/utilities/env.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, GlobalConfig, ConfigType;

import '../includes.dart';

final pageStorageBucket = PageStorageBucket();

class DictGlobalConfig {
  static void loadApp(ConfigType configType) async {
    void _handleError(Object obj, StackTrace stack) {
      AppLogHandler.restLoggerException("global error", stack, obj);
    }

    runZonedGuarded(() async {
      GlobalConfig.init(configType);
      await ProAccount.instance.ensureInitialized();
      await initEnv('stable');
      await initLocalDb();
      await initConfig();
      await EasyLocalization.ensureInitialized();
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        AppLogHandler.logFlutterErrorDetails(errorDetails);
      };
      runApp(EasyLocalization(
        supportedLocales: [
          Locale(kLanguageEN),
          // Locale(kLanguageJA),
          // Locale(kLanguageKO),
          // Locale(kLanguageRU),
          Locale(kLanguageZH),
        ],
        path: 'assets/translations',
        assetLoader: YamlAssetLoader(),
        fallbackLocale: Locale(kLanguageEN),
        child: AppNavigator(),
      ));
    }, (Object error, StackTrace stackTrace) {
      _handleError(error, stackTrace);
    });
  }
}
