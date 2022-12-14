import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../json_util.dart';

class PkuBox {
  late final Directory dir;
  late PkuBoxConfig config;

  PkuBox(Directory collectionDir, String boxPath) {
    dir = Directory(p.join(collectionDir.path, boxPath));
    readConfig();
  }

  String configPath() => p.join(dir.path, "box_config.json");

  readConfig() {
    String rawjson = File(configPath()).readAsStringSync();
    //TODO: add error checking for malformed json
    var json = jsonDecode(rawjson);
    config = PkuBoxConfig.fromJson(json);

    dev.log("Just read a box config.");
  }

  writeConfig() {
    var json = config.toJson();
    File(configPath()).writeAsStringSync(prettyPrintJson(json));

    dev.log("Just wrote a box config.");
  }
}

class PkuBoxConfig {
  late Map<int, String> slots;
  late List<String> exported;

  PkuBoxConfig({this.slots = const {}, this.exported = const []});

  PkuBoxConfig.fromJson(Map<String, dynamic> json) {
    exported = json['Exported'] != null
        ? List<String>.from(json['Exported'])
        : const [];

    slots = json['Slots'] != null
        ? Map<String, String>.from(json['Slots']).map((key, value) =>
            MapEntry(int.parse(key), value)) //key: string -> int
        : const {};
  }

  Map<String, dynamic> toJson() => {
        'Slots': slots,
        'Exported': exported,
      };

  @override
  String toString() {
    return prettyPrintJson(toJson());
  }
}
