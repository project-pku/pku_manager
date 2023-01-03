import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;

typedef JsonMap = Map<String, dynamic>;

String prettyPrintJson(JsonMap json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  return encoder.convert(json);
}

//TODO: make a json reader util method that ignores comments and trailing commas

abstract class Serializable<T> {
  //would rather an abstract factory here but dart doesn't support it.
  T fromJson(JsonMap json);
  JsonMap toJson();
}

mixin JsonConfigurable<T extends Serializable> {
  abstract T config;

  String configPath();

  void readConfig() {
    String rawjson = File(configPath()).readAsStringSync();
    //TODO: add error checking for malformed json
    var json = jsonDecode(rawjson);
    config = config.fromJson(json);

    dev.log("Just read a $runtimeType config.");
  }

  void writeConfig() {
    var json = config.toJson();
    File(configPath()).writeAsStringSync(prettyPrintJson(json));

    dev.log("Just wrote a $runtimeType config.");
  }
}
