import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingShortcutsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingShortcutsPageState();
}

class _SettingShortcutsPageState extends State<SettingShortcutsPage> {
  Config _config = sharedConfigManager.getConfig();

  String t(String key) {
    return 'page_setting_shortcuts.$key'.tr();
  }

  @override
  void initState() {
    ShortcutService.instance.stop();
    sharedConfigManager.addListener(_configListen);

    super.initState();
  }

  @override
  void dispose() {
    sharedConfigManager.removeListener(_configListen);
    super.dispose();
  }

  void _configListen() {
    _config = sharedConfigManager.getConfig();
    setState(() {});
  }

  Future<void> _handleClickRegisterNewHotKey(
    BuildContext context, {
    String? shortcutKey,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return RecordHotKeyDialog(

        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_show_or_hide')),
                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    shortcutKey: kShortcutShowOrHide,
                  );
                },
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_extract_text')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_extract_text_from_selection')),
                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    shortcutKey: kShortcutExtractFromScreenSelection,
                  );
                },
              ),
              if (!kIsLinux)
                PreferenceListItem(
                  title: Text(t('pref_item_title_extract_text_from_capture')),
                  onTap: () {
                    _handleClickRegisterNewHotKey(
                      context,
                      shortcutKey: kShortcutExtractFromScreenCapture,
                    );
                  },
                ),
              PreferenceListItem(
                title: Text(t('pref_item_title_extract_text_from_clipboard')),

                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    shortcutKey: kShortcutExtractFromClipboard,
                  );
                },
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(t('title')),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
