import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../includes.dart';

class TranslationInputView extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;


  final String translationMode;
  final ValueChanged<String> onTranslationModeChanged;
  final String inputSetting;

  final VoidCallback onClickExtractTextFromScreenCapture;
  final VoidCallback onClickExtractTextFromClipboard;

  final VoidCallback onButtonAddBook;
  final VoidCallback onButtonTappedTrans;

  const TranslationInputView({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.onChanged,
    required this.translationMode,
    required this.onTranslationModeChanged,
    required this.inputSetting,
    required this.onClickExtractTextFromScreenCapture,
    required this.onClickExtractTextFromClipboard,
    required this.onButtonAddBook,
    required this.onButtonTappedTrans,
  }) : super(key: key);

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          constraints: BoxConstraints(
            minWidth: 56,
          ),
          child: ElevatedButton(
            child: Text(
              'page_home.btn_add_book'.tr(),
              style: TextStyle(fontSize: 20),
            ),
            onPressed: this.onButtonAddBook,
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 30,
          constraints: BoxConstraints(
            minWidth: 56,
          ),
          child: ElevatedButton(
            child: Text(
              'page_home.btn_trans'.tr(),
              style: TextStyle(fontSize: 20),
            ),
            onPressed: this.onButtonTappedTrans,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

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
                    maxLines:
                        inputSetting == kInputSettingSubmitWithEnter ? 1 : 6,
                    minLines: 1,
                    onChanged: this.onChanged,
                    onSubmitted: (newValue) {
                      onButtonTappedTrans();
                    },
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
