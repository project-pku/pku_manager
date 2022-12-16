import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:io';
import '../json_util.dart';

mixin JsonConfigurable<T extends Jsonable> {
  T get config;

  String configPath();

  readConfig() {
    String rawjson = File(configPath()).readAsStringSync();
    //TODO: add error checking for malformed json
    var json = jsonDecode(rawjson);
    config.fromJson(json);

    dev.log("Just read a $runtimeType config.");
  }

  writeConfig() {
    var json = config.toJson();
    File(configPath()).writeAsStringSync(prettyPrintJson(json));

    dev.log("Just wrote a $runtimeType config.");
  }
}

mixin Jsonable {
  Map<String, dynamic> toJson();
  fromJson(Map<String, dynamic> json);

  @override
  String toString() {
    return prettyPrintJson(toJson());
  }
}
