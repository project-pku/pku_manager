import 'dart:io';
import 'package:path/path.dart' as p;
import 'pku_box.dart';
import 'json_configurable.dart';

class PkuCollection with JsonConfigurable<PkuCollectionConfig> {
  final Directory dir;
  late PkuBox currentBox;

  PkuCollection(this.dir) {
    readConfig(); //load config
    _loadBox(config.currentBoxID);
  }

  _loadBox(int boxID) {
    currentBox = PkuBox(dir, config.boxes[boxID]);
  }

  // Public API
  String get currentBoxName => config.boxes[currentBoxID];

  int get currentBoxID => config.currentBoxID;
  set currentBoxID(int id) {
    config.currentBoxID = id;
    writeConfig();
    _loadBox(config.currentBoxID);
  }

  List<String> get boxNames => config.boxes;

  // JsonConfigurable implementation
  @override
  PkuCollectionConfig config = PkuCollectionConfig();

  @override
  String configPath() => p.join(dir.path, "collection_config.json");
}

class PkuCollectionConfig with Jsonable {
  int currentBoxID = 0;
  Map<String, bool> globalFlags = const {};
  List<String> boxes = const [];

  @override
  fromJson(Map<String, dynamic> json) {
    boxes = List<String>.from(json['Boxes'] ?? const []);
    globalFlags = Map<String, bool>.from(json['Global Flags'] ?? const {});
    currentBoxID = json['Current Box ID'] ?? 0;
  }

  @override
  Map<String, dynamic> toJson() => {
        'Boxes': boxes,
        'Global Flags': globalFlags,
        'Current Box ID': currentBoxID,
      };
}
