//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars

import 'package:audioplayers/web/audioplayers_web.dart';
import 'package:device_info_plus_web/device_info_plus_web.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
<<<<<<< HEAD
import 'package:shared_preferences_web/shared_preferences_web.dart';
=======
import 'package:package_info_plus_web/package_info_plus_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:uni_links_web/uni_links_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
>>>>>>> 5c4962b082e4392dbeea3e91359bfdd3c76ee90e

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioplayersPlugin.registerWith(registrar);
  DeviceInfoPlusPlugin.registerWith(registrar);
  FluttertoastWebPlugin.registerWith(registrar);
<<<<<<< HEAD
  SharedPreferencesPlugin.registerWith(registrar);
=======
  PackageInfoPlugin.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  UniLinksPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
>>>>>>> 5c4962b082e4392dbeea3e91359bfdd3c76ee90e
  registrar.registerMessageHandler();
}
