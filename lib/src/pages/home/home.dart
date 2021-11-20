import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:reddwarfdict/src/pages/home/translation_input_view.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';
import 'home_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController _controller = Get.put(HomeController());
  final TextEditingController _textController = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  void _handleTextChanged(
      String newValue, {
        bool isRequery = false,
      }) {

  }

  void _handleExtractTextFromScreenSelection() async {

  }


  void _handleExtractTextFromScreenCapture() async {
  }

  void _handleExtractTextFromClipboard() async {

  }

  void _handleButtonTappedClear() {
  }

  void _handleButtonTappedTrans() {
  }

    Widget _buildInputView(BuildContext context) {
    return Container(
      key: GlobalKey(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TranslationInputView(
            focusNode: FocusNode(),
            controller: _textEditingController,
            onChanged: (newValue) => this._handleTextChanged(newValue),
            translationMode: "manual",
            onTranslationModeChanged: (newTranslationMode) {

            },
            inputSetting: "",
            onClickExtractTextFromScreenCapture:
            this._handleExtractTextFromScreenCapture,
            onClickExtractTextFromClipboard:
            this._handleExtractTextFromClipboard,
            onButtonTappedClear: this._handleButtonTappedClear,
            onButtonTappedTrans: this._handleButtonTappedTrans, key: GlobalKey(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsView(BuildContext context) {
    return TranslationResultsView(
      viewKey: _resultsViewKey,
      controller: _scrollController,
      translationMode: _config.translationMode,
      querySubmitted: _querySubmitted,
      text: _text,
      textDetectedLanguage: _textDetectedLanguage,
      translationResultList: _translationResultList,
      onTextTapped: (word) {
        _handleTextChanged(word, isRequery: true);
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          //_buildBannersView(context),
          _buildInputView(context),
          //_buildResultsView(context),
        ],
      ),
    );
  }

  Widget _buildLegacyBody(BuildContext context,HomeController controller) {

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child:
                TextField(
                  autofocus: false,
                  controller: _textController,
                  onChanged:  (v) {
                    print("onChange: $v");
                    _controller.updateWords(v);
                  },
                )),
            ElevatedButton(
              onPressed: () {
                _controller.fetchSearchResult();
              },
              child: Text("查询"),
            ),
          ],
        ),
        Obx(() => Text(controller.wordTrans.value.definition)),
        Column(
            children: controller.getCurrentRender
        ),
        ElevatedButton(
          onPressed: () {
            _controller.addLearningWord();
          },
          child: Text("加入生词本"),
        )
      ],
    );

  }

    @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
                child: _buildBody(context)),
          );
        });
  }
}
