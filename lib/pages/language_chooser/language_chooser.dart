import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

class LanguageChooserPage extends StatefulWidget {
  final String initialLanguage;
  final ValueChanged<String> onChoosed;

  const LanguageChooserPage({
    Key? key,
    required this.initialLanguage,
    required this.onChoosed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LanguageChooserPageState();
}

class _LanguageChooserPageState extends State<LanguageChooserPage> {
  String? _language;

  String t(String key, {List<String>? args}) {
    return 'page_language_chooser.$key'.tr(args: args);
  }

  @override
  void initState() {
    _language = widget.initialLanguage;
    super.initState();
  }

  void _handleClickOk() async {
    if (widget.onChoosed != null) {
      widget.onChoosed(_language!);
    }

    Navigator.of(context).pop();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text(t('title')),
      actions: [
        CustomAppBarActionItem(
          text: 'ok'.tr(),
          onPressed: _handleClickOk,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: PreferenceList(
        children: [
          PreferenceListSection(
            title: Text(t('pref_section_title_all')),
            children: [
              for (var supportedLanguage in kSupportedLanguages)
                PreferenceListRadioItem(
                  title: LanguageLabel(supportedLanguage),
                  accessoryView: Container(),
                  value: supportedLanguage,
                  groupValue: _language,
                  onChanged: (newGroupValue) {
                    _language = supportedLanguage;
                    setState(() {});
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}
