import 'dart:async';

import 'package:biyi_app/pages/app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, GlobalConfig,ConfigType;

final pageStorageBucket = PageStorageBucket();

class DictGlobalConfig {
  static void loadApp(ConfigType configType) async{
    GlobalConfig.init(configType);
    void _handleError(Object obj, StackTrace stack) {
      AppLogHandler.logErrorStack("global error",obj, stack);
    }
    runZonedGuarded((){
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        AppLogHandler.logFlutterErrorDetails(errorDetails);
      };
      runApp(
          App()
      );
    },(Object error,StackTrace stackTrace){
      _handleError(error,stackTrace);
    });
  }
}




