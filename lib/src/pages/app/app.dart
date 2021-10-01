import 'package:flutter/cupertino.dart';
import 'package:reddwarfdict/src/pages/nav/nav.dart';

import 'global_controller.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      init: GlobalController(),
      builder:(controller){
        return GetMaterialApp(
          title:"dict",
          home: Nav(),
        );
      }
    );
  }
}
