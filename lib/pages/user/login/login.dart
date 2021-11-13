import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:reddwarf_dict/component/dialogs.dart';
import 'package:reddwarf_dict/component/page_dia_code_selection.dart';
import 'package:reddwarf_dict/networking/rest_api/login/login_provider.dart';
import 'package:reddwarf_dict/pages/user/login/phone_input.dart';
import 'package:reddwarf_dict/themes/global_style.dart';
import 'package:wheel/wheel.dart';

import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({Key key,this.regions}) : super(key: key);

  final List<RegionFlag> regions;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          double screenWidth = MediaQuery
              .of(context)
              .size
              .width;
          final inputController = useTextEditingController();
          final selectedRegion = useState<RegionFlag>(useMemoized(() {
            // initial to select system default region.
            final countryCode = window.locale.countryCode;
            return regions.firstWhere((region) => region.code == countryCode,
                orElse: () => regions[0]);
          }));

          Future<void> onNextClick() async {
            final text = inputController.text;
            if (text.isEmpty) {
              return;
            }

            final result = await showLoaderOverlay(
              context,
              LoginApi.checkPhoneExist(
                text,
                selectedRegion.value.dialCode
                    .replaceAll("+", "")
                    .replaceAll(" ", ""),
              ),
            );
            if (result.isError) {
              //toast(result.asError!.error.toString());
              return;
            }
            final value = result.asValue.value;
            if (!value.isExist) {
              //toast('注册流程开发未完成,欢迎贡献代码...');
              return;
            }
            if (!value.hasPassword) {
              //toast('无密码登录流程的开发未完成,欢迎提出PR贡献代码...');
              return;
            }
            Navigator.pushNamed(context, "pageLoginPassword",
                arguments: {'phone': text});
          }


          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text("红矮星词典"),
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
                              PhoneInput(
                                controller: inputController,
                                selectedRegion: selectedRegion.value,
                                onPrefixTap: () async {
                                  final RegionFlag region = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return RegionSelectionPage(regions: regions);
                                    }),
                                  );
                                  if (region != null) {
                                    selectedRegion.value = region;
                                  }
                                },
                                onDone: onNextClick,
                              ),
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
