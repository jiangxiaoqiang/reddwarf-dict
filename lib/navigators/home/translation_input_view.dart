import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../includes.dart';

class TranslationInputView extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  final String translationMode;
  final ValueChanged<String> onTranslationModeChanged;
  final String inputSetting;

  final VoidCallback onClickExtractTextFromScreenCapture;
  final VoidCallback onClickExtractTextFromClipboard;

  final VoidCallback onButtonTappedClear;
  final VoidCallback onButtonTappedTrans;

  const TranslationInputView({
     required Key key,
     required this.focusNode,
     required this.controller,
     required this.onChanged,
     required this.translationMode,
     required this.onTranslationModeChanged,
     required this.inputSetting,
     required this.onClickExtractTextFromScreenCapture,
     required this.onClickExtractTextFromClipboard,
     required this.onButtonTappedClear,
     required this.onButtonTappedTrans,
  }) : super(key: key);

  Widget _buildTextGetters(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message: 'page_home.tip_translation_mode'.tr(args: [
            'translation_mode.${this.translationMode}'.tr(),
          ]),
          child: SizedBox(
            width: 30,
            height: 26,
            child: ElevatedButton(
              child: Container(
                width: 30,
                height: 26,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                      Positioned(
                        bottom: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          padding: EdgeInsets.only(
                            left: 2,
                            right: 2,
                            top: 1.4,
                            bottom: 1.4,
                          ),
                          child: Text(
                            'AUTO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 5.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              onPressed: () {

              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
          child: VerticalDivider(
            width: 8,
          ),
        ),
        Tooltip(
          message: 'page_home.tip_extract_text_from_screen_capture'.tr(),
          child: SizedBox(
            width: 30,
            height: 26,
          ),
        ),
        Tooltip(
          message: 'page_home.tip_extract_text_from_clipboard'.tr(),
          child: SizedBox(
            width: 30,
            height: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          constraints: BoxConstraints(
            minWidth: 56,
          ),
          child: ElevatedButton(
            child: Text(
              'page_home.btn_clear'.tr(),
              style: TextStyle(fontSize: 12),
            ),
            onPressed: this.onButtonTappedClear,
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 24,
          constraints: BoxConstraints(
            minWidth: 56,
          ),
          child: ElevatedButton(
            child: Text(
              'page_home.btn_trans'.tr(),
              style: TextStyle(fontSize: 12),
            ),
            onPressed: this.onButtonTappedTrans,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isTextDetecting = false;

    return Container(
      margin: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 0,
        bottom: 12,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: Offset(0.0, 1.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  CupertinoTextField(
                    focusNode: focusNode,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    selectionHeightStyle: BoxHeightStyle.max,
                    controller: this.controller,
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 14,
                      bottom: 12,
                    ),
                    style:
                        CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                              fontSize: 14,
                              height: 1.2,
                            ),
                    placeholder: 'page_home.input_hint'.tr(),
                    minLines: 1,
                    onChanged: this.onChanged,
                    onSubmitted: (newValue) {
                      onButtonTappedTrans();
                    },
                  ),
                  if (isTextDetecting)
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        color: Theme.of(context).canvasColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SpinKitDoubleBounce(
                                  color: Color.fromARGB(1, 1, 1, 1),
                                  size: 18.0,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'page_home.text_extracting_text'.tr(),
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Divider(
              height: 0,
              indent: 12,
              endIndent: 12,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 6,
                right: 12,
                top: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  _buildTextGetters(context),
                  Expanded(child: Container()),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
