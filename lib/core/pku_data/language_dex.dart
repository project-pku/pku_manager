import 'package:meta/meta.dart';
import 'package:pku_manager/core/pku_data/format_dex.dart';
import 'dex.dart';

class LanguageDex extends Dex with HasIndexedVals {
  @override
  @protected
  final FormatDex formatDex;
  LanguageDex(super.json, this.formatDex);

  bool languageExists(String format, String language) =>
      existsIn(language, format);

  int? tryGetLanguageID(String format, String language) {
    if (!languageExists(format, language)) return null;
    return tryGetIndexedValue(indexChain(format), [language, "Indices"]);
  }

  String? tryGetLanguageName(String format, int langId) {
    String? langName =
        tryGetIndexedKey(indexChain(format), [blankKey, "Indices"], langId);
    if (langName != null && languageExists(format, langName)) return langName;
    return null;
  }
}
