import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../includes.dart';
import 'nav/nav_page.dart';

class AppNavigator extends StatefulWidget {
  final Widget? home;

  const AppNavigator({
    Key? key,
    this.home,
  }) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> with WidgetsBindingObserver {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  Config _config = sharedConfigManager.getConfig();

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    sharedConfigManager.addListener(_configListen);
    if (widget.home == null) {
      R.setNavigatorKey(_navigatorKey);
    }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    sharedConfigManager.removeListener(_configListen);
    super.dispose();
  }

  void _configListen() {
    _config = sharedConfigManager.getConfig();
    setState(() {});
  }

  void didChangePlatformBrightness() {
    setState(() {});
  }

  bool get isRootPage {
    return widget.home == null;
  }

  Widget _build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: isRootPage ? _navigatorKey : null,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: _config.themeMode!,
      builder: (context, child) {
        if (isRootPage) {
          child = botToastBuilder(context, child);
        }
        return child!;
      },
      navigatorObservers: isRootPage ? [BotToastNavigatorObserver()] : [],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Nav(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
