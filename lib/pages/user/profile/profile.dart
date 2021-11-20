import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheel/wheel.dart';
import 'package:intl/intl.dart';

class Profile extends StatelessWidget {
  const Profile({Key key,this.user}) : super(key: key);

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    String timestamp = user.registerTime == null ? "0" : user.registerTime;
    var format = new DateFormat("yMd");
    var dateString = timestamp == "0" ? "--" : format.format(new DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)));

    return Scaffold(
        backgroundColor: const Color(0xFFEFEFEF),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Map<String,Object> args = new Map();
                args.putIfAbsent("selectIndex", () => 3);
                args.putIfAbsent("autoTriggerNav", () => true);
              }),
          title: Text(
            "个人信息",
          ),

          actions: [
              IconButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("登出"),
                        content: Text("确定要登出么?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "取消",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Auth.logout();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              "登出",
                              style: TextStyle(color: Colors.red[400]),
                            ),
                          ),
                        ],
                      );
                    }),
                icon: Icon(
                  EvaIcons.logOut,
                ),
              ),
          ],
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              color: Colors.white,
                              child: ListTile(
                                title: Text("用户名"),
                                subtitle: Text(user.phone == null ? "--" : user.phone),
                                onTap: () async {},
                              ))))),
              SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              color: Colors.white,
                              child: ListTile(
                                title: Text("注册时间"),
                                subtitle: Text(dateString),
                                onTap: () async {},
                              ))))),
            ],
          ),
        ),
      );
  }
}