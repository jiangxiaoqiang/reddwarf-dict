import 'package:tray_manager/tray_manager.dart';

import './config.dart';
import './env.dart';

// 请按文件名排序放置
export './config.dart';
export './env.dart';
export './language_util.dart';
export './platform_util.dart';
export './pretty_json.dart';
export './r.dart';
export './remove_nulls.dart';

final sharedEnv = Env.instance;
final sharedConfig = Config.instance;
final sharedConfigManager = ConfigManager.instance;

final TrayManager trayManager = TrayManager.instance;
