import 'dart:async';

import 'package:biyi_app/navigators/app_navigator.dart';
import 'package:biyi_app/networking/local_db/local_db.dart';
import 'package:biyi_app/utilities/config.dart';
import 'package:biyi_app/utilities/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, GlobalConfig,ConfigType;

import '../includes.dart';

final pageStorageBucket = PageStorageBucket();

class DictGlobalConfig {
  static void loadApp(ConfigType configType) async{
    GlobalConfig.init(configType);
    await ProAccount.instance.ensureInitialized();
    await initEnv('stable');
    await initLocalDb();
    await initConfig();
    void _handleError(Object obj, StackTrace stack) {
      AppLogHandler.restLogger("global error" + stack.toString());
    }
    runZonedGuarded((){
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        AppLogHandler.logFlutterErrorDetails(errorDetails);
      };
      runApp(
          AppNavigator()
      );
    },(Object error,StackTrace stackTrace){
      _handleError(error,stackTrace);
    });
  }
}




