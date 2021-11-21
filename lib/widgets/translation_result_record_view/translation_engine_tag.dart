import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_translate/uni_translate.dart';

import '../../includes.dart';

class TranslationEngineTag extends StatefulWidget {
  final TranslationResultRecord? translationResultRecord;

  const TranslationEngineTag({
     Key? key,
    this.translationResultRecord,
  }) : super(key: key);

  @override
  _TranslationEngineTagState createState() => _TranslationEngineTagState();
}

class _TranslationEngineTagState extends State<TranslationEngineTag> {
  bool _isHovered = false;

  TranslationEngineConfig get _translationEngineConfig {
    TranslationEngineConfig engineConfig = sharedLocalDb.engines.list(where: (TranslationEngineConfig element) {
      return true;
    }).first;
    return engineConfig;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _isHovered = true;
        setState(() {});
      },
      onExit: (event) {
        _isHovered = false;
        setState(() {});
      },
      child: Container(
        height: 40,
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          padding: EdgeInsets.only(top: 3, bottom: 3, left: 4, right: 2),
          child: CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: AnimatedCrossFade(
              crossFadeState: !_isHovered
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
              firstCurve: Curves.ease,
              secondCurve: Curves.ease,
              sizeCurve: Curves.ease,
              firstChild: Row(
                children: [
                  TranslationEngineIcon(
                    _translationEngineConfig,
                    size: 12,
                  ),
                ],
              ),
              secondChild: Row(
                children: [

                  Padding(
                    padding: EdgeInsets.only(left: 4, right: 2),
                    child: Text(
                      _translationEngineConfig.typeName??"Unknown",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 10,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
