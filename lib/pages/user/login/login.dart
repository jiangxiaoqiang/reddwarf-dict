import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:reddwarf_dict/themes/global_style.dart';

import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          double screenWidth = MediaQuery
              .of(context)
              .size
              .width;

          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text("Cruise"),
                actions: [
                  TextButton(
                    style: GlobalStyle.textButtonStyle,
                    onPressed: () {
                      //Navigator.push(context,
                      //    MaterialPageRoute(builder: (context) => RegPage(phoneNumber: username.value)));
                    },
                    child: Text("注册", style: TextStyle(fontSize: 16.0)),
                  ),
                ],
              ),
              body: Form(
                key: GlobalKey(),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Row(
                            children: [
                              /*CountryCodePicker(
                                onChanged: (CountryCode country) {
                                  countryCode.value = country.toString();
                                },
                                initialSelection: 'CN',
                                favorite: ['+86', 'ZH'],
                                // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                                flagDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),*/
                              SizedBox(
                                  height: 45,
                                  width: screenWidth * 0.7,
                                  child: TextFormField(
                                    autocorrect: false,
                                    onChanged: (value) {
                                      //username.value = value;
                                    },
                                    keyboardType: TextInputType.phone,
                                    obscureText: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "电话号码不能为空";
                                      }
                                      //phoneValid.value = true;
                                      return null;
                                    },
                                  ))
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16, top: 32),
                        child: TextFormField(
                          autocorrect: false,
                          onChanged: (value) {
                            //password.value = value;
                          },
                          //obscureText: showPassword.value,
                          decoration: InputDecoration(
                              labelText: '密码',
                              contentPadding: EdgeInsets.all(10.0), //控制输入控件高度
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  //showPassword.value = !showPassword.value;
                                },
                              )),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "密码不能为空";
                            }
                            return null;
                          },
                        ),
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                            child: Builder(
                              builder: (context) {
                                return ButtonTheme(
                                    minWidth: screenWidth * 0.85,
                                    height: 50.0,
                                    child: Center(
                                        child: ElevatedButton(
                                          style: GlobalStyle.getButtonStyle(context),
                                          onPressed: () async {

                                          },
                                          child: controller.submitting.value
                                              ? SizedBox(
                                            height: 45,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                            ),
                                          )
                                              : Text("登录"),
                                        )));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
          );
        });
  }
}
