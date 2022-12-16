import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:pku_manager/core/pku_collection/json_configurable.dart';

class PkuBox with JsonConfigurable {
  final Directory dir;

  PkuBox(Directory collectionDir, String boxPath)
      : dir = Directory(p.join(collectionDir.path, boxPath)) {
    readConfig();
  }

  // JsonConfigurable implementation
  @override
  PkuBoxConfig config = PkuBoxConfig();

  @override
  String configPath() => p.join(dir.path, "box_config.json");
}

class PkuBoxConfig with Jsonable {
  Map<int, String> slots = const {};
  List<String> exported = const [];

  @override
  fromJson(Map<String, dynamic> json) {
    exported = List<String>.from(json['Exported'] ?? const []);
    slots = Map<String, String>.from(json['Slots'] ?? const {})
        .map((key, value) => MapEntry(int.parse(key), value));
  }

  @override
  Map<String, dynamic> toJson() => {
        'Slots': slots,
        'Exported': exported,
      };
}
