import '../../../includes.dart';

import '../local_db.dart';

class EnginesModifier {
  final DbData dbData;

  EnginesModifier(this.dbData,this._id);

  String? _id;

  void setId(String? id) {
    _id = id;
  }

  int get _engineIndex {
    return dbData.engineList.indexWhere((e) => e.identifier == _id);
  }

  List<TranslationEngineConfig> get _engineList {
    return dbData.engineList;
  }

  List<TranslationEngineConfig> list({
    required bool where(TranslationEngineConfig element),
  }) {
    if (where != null) {
      return _engineList.where(where).toList();
    }
    return _engineList;
  }

  TranslationEngineConfig get() {
    return _engineList[_engineIndex];
  }

  bool exists() {
    return _engineIndex != -1;
  }
}
