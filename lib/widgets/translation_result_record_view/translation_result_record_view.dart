import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uni_translate/uni_translate.dart';

import '../../includes.dart';

import 'translation_engine_tag.dart';
import 'word_image_view.dart';
import 'word_phrase_view.dart';
import 'word_pronunciation_view.dart';
import 'word_sentence_view.dart';
import 'word_tag_view.dart';
import 'word_translation_view.dart';

class TranslationResultRecordView extends StatelessWidget {
  final TranslationResult translationResult;
  final TranslationResultRecord translationResultRecord;
  final ValueChanged<String> onTextTapped;

  const TranslationResultRecordView({
     Key key,
     this.translationResult,
     this.translationResultRecord,
     this.onTextTapped,
  }) : super(key: key);

  bool get _isLoading {
    if (_isErrorOccurred) return false;
    return translationResultRecord.lookUpResponse == null &&
        translationResultRecord.translateResponse == null;
  }

  bool get _isErrorOccurred {
    return translationResultRecord.lookUpError != null ||
        translationResultRecord.translateError != null;
  }

  Widget _buildRequestLoading(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 40,
      ),
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitThreeBounce(
            color: Color.fromARGB(1, 1, 1, 1),
            size: 12.0,
          ),
        ],
      ),
    );
  }

  Widget _buildRequestError(BuildContext context) {
    UniTranslateClientError error = translationResultRecord.lookUpError ??
        translationResultRecord.translateError;

    return Container(
      constraints: BoxConstraints(
        minHeight: 40,
      ),
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(error?.message ?? 'Unknown Error'),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    String word;
    List<TextTranslation> translations; // 翻译
    List<WordTag> tags; // 标签
    List<WordDefinition> definitions; // 定义（基本释义）
    List<WordPronunciation> pronunciations; // 发音
    List<WordImage> images; // 图片
    List<WordPhrase> phrases; // 短语
    List<WordTense> tenses; // 时态
    List<WordSentence> sentences; // 例句

    if (translationResultRecord.lookUpResponse != null) {
      final resp = translationResultRecord.lookUpResponse;
      word = resp.word;
      translations = resp.translations;
      tags = resp.tags;
      definitions = resp.definitions;
      pronunciations = resp.pronunciations;
      images = resp.images;
      phrases = resp.phrases;
      tenses = resp.tenses;
      sentences = resp.sentences;
    } else if (translationResultRecord.translateResponse != null) {
      final resp = translationResultRecord.translateResponse;
      translations = resp.translations;
    }

    // 是否显示为查词结果
    bool isShowAsLookUpResult = (definitions ?? []).isNotEmpty ||
        (pronunciations ?? []).isNotEmpty ||
        (images ?? []).isNotEmpty;

    if (!isShowAsLookUpResult) {
      return Container(
        constraints: BoxConstraints(
          minHeight: 40,
        ),
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 7,
          bottom: 7,
        ),
        alignment: Alignment.centerLeft,
        child: SelectableText.rich(
          TextSpan(
            children: [
              for (var translation in (translations ?? []))
                TextSpan(text: translation.text)
            ],
          ),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
            height: 1.4,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 14,
      ),
      constraints: BoxConstraints(
        minHeight: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 翻译
          if ((translations ?? []).isNotEmpty)
            WordTranslationView(translations.first),
          // 包含查词结果时显示分割线
          if ((translations ?? []).isNotEmpty) Divider(height: 0),
          // 音标
          if ((pronunciations ?? []).isNotEmpty)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 12, bottom: 4),
              child: Wrap(
                spacing: 22,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  for (WordPronunciation wordPronunciation in pronunciations)
                    WordPronunciationView(wordPronunciation)
                ],
              ),
            ),
          // 释义
          if ((definitions ?? []).isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 4, bottom: 4),
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    for (var i = 0; i < definitions.length; i++)
                      TextSpan(
                        children: [
                          if ((definitions[i].name ?? '').isNotEmpty)
                            TextSpan(
                              text: '${definitions[i].name}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          if ((definitions[i].name ?? '').isNotEmpty)
                            TextSpan(text: ' '),
                          TextSpan(text: definitions[i].values.join('；')),
                          if (i < definitions.length - 1) TextSpan(text: '\n'),
                        ],
                      ),
                  ],
                ),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  height: 1.5,
                ),
              ),
            ),
          // 时态
          if ((tenses ?? []).isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 4),
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    for (var i = 0; i < tenses.length; i++)
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${tenses[i].name}',
                          ),
                          for (var tenseValue in tenses[i].values)
                            TextSpan(
                              text: ' $tenseValue ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => this.onTextTapped(tenseValue),
                            ),
                        ],
                        style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  height: 1.5,
                ),
              ),
            ),
          // 图片
          if ((images ?? []).isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: kWordImageSize,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i = 0; i < images.length; i++)
                    WordImageView(
                      images[i],
                      onPressed: () {
                        Navigator.push(
                          context,
                          FadeInPageRoute(
                            builder: (context) => ImageViewerPage(
                              images.map((e) => e.url).toList(),
                              initialIndex: i,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          if ((tags ?? []).isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (WordTag wordTag in tags) WordTagView(wordTag),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 0,
        bottom: 12,
      ),
      child: Container(
        width: double.infinity,
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
        child: Stack(
          children: [
            if (_isLoading)
              _buildRequestLoading(context)
            else if (_isErrorOccurred)
              _buildRequestError(context)
            else
              _buildBody(context),
            Positioned(
              right: 0,
              top: 0,
              child: TranslationEngineTag(
                translationResultRecord: translationResultRecord,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
