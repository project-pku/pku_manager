import 'pku_dex_client.dart';
import 'format_dex.dart';
import 'language_dex.dart';

class PkuDataClient extends PkuDexClient {
  @override
  String get baseUrl =>
      "https://raw.githubusercontent.com/project-pku/pkuData/build";

  static PkuDataClient? _instance;
  PkuDataClient._();

  late final FormatDex format = FormatDex(dexMap['Format']!);
  late final LanguageDex language = LanguageDex(dexMap['Language']!, format);

  static Future<PkuDataClient> getClient() async {
    if (_instance == null) {
      PkuDataClient temp = PkuDataClient._();
      await temp.initialize();
      _instance = temp;
    }
    return _instance!;
  }
}
