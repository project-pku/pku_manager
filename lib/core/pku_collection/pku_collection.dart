import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
import '../json_util.dart';
import 'pku_box.dart';

part 'pku_collection.g.dart';

class PkuCollection with JsonConfigurable<PkuCollectionConfig> {
  final Directory dir;
  @override
  String configPath() => p.join(dir.path, "collection_config.json");
  @override
  PkuCollectionConfig config = PkuCollectionConfig();
  late PkuBox currentBox;

  PkuCollection(this.dir) {
    readConfig(); //load config
    _loadBox(config.currentBoxID);
  }

  void _loadBox(int boxID) {
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
}

@JsonSerializable()
class PkuCollectionConfig implements Serializable {
  @JsonKey(name: "Current Box ID", defaultValue: 0)
  int currentBoxID = 0;
  @JsonKey(name: "Global Flags", defaultValue: {})
  Map<String, bool> globalFlags = const {};
  @JsonKey(name: "Boxes", defaultValue: [])
  List<String> boxes = const [];

  @override
  PkuCollectionConfig fromJson(JsonMap json) =>
      _$PkuCollectionConfigFromJson(json);
  @override
  JsonMap toJson() => _$PkuCollectionConfigToJson(this);
}
