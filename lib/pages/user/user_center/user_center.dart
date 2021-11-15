import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:reddwarf_dict/pages/user/login/login.dart';
import 'package:reddwarf_dict/pages/user/profile/profile.dart';
import 'package:wheel/wheel.dart';

import 'user_center_controller.dart';

class UserCenter extends StatelessWidget {
  const UserCenter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserCenterController>(
        init: UserCenterController(),
        builder: (controller) {
          double screenWidth = MediaQuery.of(context).size.width;

          return Scaffold(
            backgroundColor: const Color(0xFFEFEFEF),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
                child: ListView(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                color: Colors.white,
                                child: ListTile(
                                  leading: Icon(EvaIcons.person),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  title: Text("我的"),
                                  onTap: () async {
                                    bool isLoggedIn = await Auth.isLoggedIn();
                                    if (isLoggedIn) {
                                      var user = await Auth.currentUser();
                                      Get.to(Profile(user: user,));
                                    } else {
                                      List<RegionFlag> regions = await CommonUtils.getRegions();
                                      final inputController = TextEditingController();
                                      Get.to(Login(regions: regions,inputController: inputController));
                                    }
                                  },
                                )))),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
