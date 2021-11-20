import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingExtractTextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingExtractTextPageState();
}

class _SettingExtractTextPageState
    extends State<SettingExtractTextPage> {
  bool _useLocalOcrEngine = false;
  OcrEngineConfig _defaultOcrEngineConfig;

  String t(String key, {List<String> args}) {
    return 'page_setting_extract_text.$key'.tr(args: args);
  }

  @override
  void initState() {
    _useLocalOcrEngine = sharedConfig.useLocalOcrEngine;
    _defaultOcrEngineConfig =
        sharedLocalDb.ocrEngine(sharedConfig.defaultOcrEngineId).get();
    super.initState();
  }

  void _handleUseLocalOcrEngineChanged(newValue) {
    _useLocalOcrEngine = newValue;
    sharedConfigManager.setUseLocalOcrEngine(newValue);
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          // PreferenceListSection(
          //   children: [
          //     PreferenceListSwitchItem(
          //       title: Text(
          //         t('pref_section_title_use_local_detect_text_engine'),
          //       ),
          //       value: _useLocalOcrEngine,
          //       onChanged: _handleUseLocalOcrEngineChanged,
          //     ),
          //   ],
          // ),
          if (!_useLocalOcrEngine)
            PreferenceListSection(
              title: Text(t('pref_section_title_default_detect_text_engine')),
              children: [
                PreferenceListItem(
                  icon: _defaultOcrEngineConfig == null
                      ? null
                      : OcrEngineIcon(
                          _defaultOcrEngineConfig,
                        ),
                  title: Builder(builder: (_) {
                    if (_defaultOcrEngineConfig == null)
                      return Text('please_choose'.tr());
                    return Text.rich(
                      TextSpan(
                        text: _defaultOcrEngineConfig.typeName,
                        children: [
                          TextSpan(
                            text: ' (${_defaultOcrEngineConfig.shortId})',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    );
                  }),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OcrEngineChooserPage(
                          initialOcrEngineConfig: _defaultOcrEngineConfig,
                          onChoosed: (ocrEngineConfig) {
                            sharedConfigManager.setDefaultOcrEngineId(
                              ocrEngineConfig.identifier,
                            );
                            setState(() {
                              _defaultOcrEngineConfig = ocrEngineConfig;
                            });
                          },
                        ),
                      ),
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
