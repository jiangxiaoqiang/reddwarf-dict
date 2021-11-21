import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

class TranslationResultView extends StatelessWidget {
  final TranslationResult translationResult;

  const TranslationResultView(
    this.translationResult, {
    Key? key,
  }) : super(key: key);

  String get sourceLanguage =>
      translationResult.translationTarget.sourceLanguage;
  String get targetLanguage =>
      translationResult.translationTarget.targetLanguage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 0,
        bottom: 12,
      ),
      child: Container(
        height: 40,
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
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            CustomButton(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: LanguageLabel(
                sourceLanguage,
                flagSize: 18,
              ),
              onPressed: () => {}, processing: null,
            ),
            SizedBox(
              width: 20,
              height: 38,
              child: CustomButton(
                padding: EdgeInsets.zero,
                child: Container(
                  child: Icon(
                    IcoMoonIcons.arrow_right,
                    size: 17,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                onPressed: () {}, processing: null,
              ),
            ),
            CustomButton(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: LanguageLabel(
                targetLanguage,
                flagSize: 18,
              ),
              onPressed: () => {}, processing: null,
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
