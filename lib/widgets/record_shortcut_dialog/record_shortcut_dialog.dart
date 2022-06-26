import 'package:flutter/material.dart';

import '../../includes.dart';
import '../custom_alert_dialog/custom_alert_dialog.dart';

class RecordHotKeyDialog extends StatefulWidget {

  const RecordHotKeyDialog({
    Key? key,
  }) : super(key: key);

  @override
  _RecordHotKeyDialogState createState() => _RecordHotKeyDialogState();
}

class _RecordHotKeyDialogState extends State<RecordHotKeyDialog> {


  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: Text('widget_record_shortcut_dialog.title'.tr()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [

                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[

      ],
    );
  }
}
