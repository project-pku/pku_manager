import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
import '../json_util.dart';
import '../pku/pku.dart';

part 'pku_box.g.dart';

class PkuBox with JsonConfigurable<PkuBoxConfig> {
  final Directory dir;
  @override
  String configPath() => p.join(dir.path, "box_config.json");
  @override
  PkuBoxConfig config = PkuBoxConfig();
  final Map<String, Pku> _pkus = {};

  PkuBox(Directory collectionDir, String boxPath)
      : dir = Directory(p.join(collectionDir.path, boxPath)) {
    readConfig();
    _readBox();
  }

  _readBox() {
    List<FileSystemEntity> entities = dir.listSync(followLinks: false);
    for (var e in entities) {
      //can force rename all pku extensions in box to lower
      if (p.extension(e.path) != ".pku") continue;

      String filename = p.basename(e.path);
      if (!config.slots.values.contains(filename)) {
        throw Exception("Loading new pkus is not supported yet.");
      }

      _pkus[p.basename(e.path)] = Pku.fromFile(e.path);
    }
  }

  // Public API
  Pku? getPkuAtSlot(int i) => _pkus[getFileNameAtSlot(i)];
  String? getFileNameAtSlot(int i) => config.slots[i];
}

@JsonSerializable()
class PkuBoxConfig implements Serializable {
  @JsonKey(name: "Exported", defaultValue: [])
  List<String> exported;
  @JsonKey(name: "Slots", defaultValue: {})
  Map<int, String> slots;

  PkuBoxConfig({this.slots = const {}, this.exported = const []});

  @override
  PkuBoxConfig fromJson(Map<String, dynamic> json) =>
      _$PkuBoxConfigFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PkuBoxConfigToJson(this);
}
