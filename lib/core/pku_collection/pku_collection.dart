import 'dart:developer' as dev;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:pku_manager/core/pku_collection/pku_box.dart';
import '../json_util.dart';

class PkuCollection extends ChangeNotifier {
  final Directory dir;
  late PkuBox currentBox;
  late _PkuCollectionConfig _config;

  PkuCollection(this.dir) {
    _readConfig(); //load config
    currentBox = PkuBox(dir, _config.boxes[_config.currentBoxID]);
  }

  // Public API
  String get currentBoxName => _config.boxes[currentBoxID];

  int get currentBoxID => _config.currentBoxID;
  set currentBoxID(int id) {
    _config.currentBoxID = id;
    _writeConfig();
    notifyListeners();
  }

  // Private methods
  String _configPath() => p.join(dir.path, "collection_config.json");

  _readConfig() {
    String rawjson = File(_configPath()).readAsStringSync();
    //TODO: add error checking for malformed json
    var json = jsonDecode(rawjson);
    _config = _PkuCollectionConfig.fromJson(json);

    dev.log("Just read a pku collection config.");
  }

  _writeConfig() {
    var json = _config.toJson();
    File(_configPath()).writeAsStringSync(prettyPrintJson(json));

    dev.log("Just wrote a pku collection config.");
  }
}

class _PkuCollectionConfig {
  int currentBoxID;
  Map<String, bool> globalFlags;
  List<String> boxes;

  _PkuCollectionConfig(
      {this.boxes = const [],
      this.globalFlags = const {},
      this.currentBoxID = 0});

  _PkuCollectionConfig.fromJson(Map<String, dynamic> json)
      : boxes = List<String>.from(json['Boxes'] ?? const []),
        globalFlags = Map<String, bool>.from(json['Global Flags'] ?? const {}),
        currentBoxID = json['Current Box ID'] ?? 0;

  Map<String, dynamic> toJson() => {
        'Boxes': boxes,
        'Global Flags': globalFlags,
        'Current Box ID': currentBoxID,
      };

  @override
  String toString() {
    return prettyPrintJson(toJson());
  }
}
