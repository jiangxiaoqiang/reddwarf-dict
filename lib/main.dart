import 'package:reddwarfdict/src/common/config/dict_global_config.dart';
import 'package:wheel/wheel.dart' show CommonUtils,ConfigType;

void main() {
  CommonUtils.initialApp(ConfigType.PRO).whenComplete(() => {
    DictGlobalConfig.loadApp(ConfigType.PRO)
  });
}




