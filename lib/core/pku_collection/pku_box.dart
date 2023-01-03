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

  void _readBox() {
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

  bool slotIsCheckedOut(int i) {
    String? filename = getFileNameAtSlot(i);
    if (filename == null) return false; //no pku exists at slot i
    return config.exported.contains(filename);
  }

  bool checkOutPkuAtSlot(int i) {
    String? filename = getFileNameAtSlot(i);
    if (filename == null) return false; //no pku exists at slot i
    config.exported.add(filename);
    writeConfig();
    return true; //check-out successful
  }

  void checkInPkuAtSlot(int i, Pku pku) {
    //make sure pku was checked-out in the first place
    if (!slotIsCheckedOut(i)) {
      throw Exception("Can't check-in a pku that hasn't been checked-out.");
    }

    //overwrite pku in filesystem
    String? filename = getFileNameAtSlot(i);
    if (filename == null) {
      throw Exception("This slot is checked-out but has no pku in it.");
    }
    String absolutePath = p.join(dir.path, filename);
    File(absolutePath).writeAsStringSync(pku.toJson(prettyPrint: true));

    //update copy in pkuManager memory
    _pkus[filename] = pku;

    //remove from checked-out list
    config.exported.remove(filename);

    //TODO: make sure config is always in a valid state (e.g. remove duplicates on load, exported only contains pku in slots)
  }
}

@JsonSerializable()
class PkuBoxConfig implements Serializable {
  @JsonKey(name: "Checked-out")
  List<String> exported;
  @JsonKey(name: "Slots")
  Map<int, String> slots;

  PkuBoxConfig({this.slots = const {}, this.exported = const []});

  @override
  PkuBoxConfig fromJson(JsonMap json) => _$PkuBoxConfigFromJson(json);
  @override
  JsonMap toJson() => _$PkuBoxConfigToJson(this);
}
