import 'package:wheel/wheel.dart';
import 'config/dict_global_config.dart';

void main() async {
  CommonUtils.initialApp(ConfigType.DEV).whenComplete(() => {
    DictGlobalConfig.loadApp(ConfigType.DEV)
  });
}
