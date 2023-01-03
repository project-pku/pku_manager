import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:pku_manager/core/http_util.dart';
import '../json_util.dart';

abstract class PkuDexClient {
  String get baseUrl;

  @protected
  final Map<String, JsonMap> dexMap = {};

  @protected
  Future<void> initialize() async {
    String configRaw = await downloadFile("$baseUrl/config.json");
    JsonMap config = json.decode(configRaw);
    JsonMap dexmap = config['Dexes'];
    await Future.forEach(dexmap.entries, (kvp) async {
      String dexRaw = await downloadFile("$baseUrl/${kvp.value}");
      dexMap[kvp.key] = jsonDecode(dexRaw);
    });
  }
}
