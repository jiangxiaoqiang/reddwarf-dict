import 'package:reddwarfdict/src/common/config/dict_global_config.dart';
import 'package:wheel/wheel.dart' show CommonUtils,ConfigType;

void main() {
  CommonUtils.initialApp(ConfigType.DEV).whenComplete(() => {
    DictGlobalConfig.loadApp(ConfigType.DEV)
  });
}




