import 'package:flutter/material.dart';

class R {
  static GlobalKey<NavigatorState>? _navigatorKey;

  static setNavigatorKey(GlobalKey navigatorKey) {
    _navigatorKey = navigatorKey as GlobalKey<NavigatorState>?;
  }

  static GlobalKey<NavigatorState>? getNavigatorKey() {
    return _navigatorKey;
  }

  static String image(String name) {
    return 'assets/images/$name';
  }
}
