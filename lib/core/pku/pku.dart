import 'dart:io';
import 'dart:developer' as dev;

import 'package:json5/json5.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(ignoreDefaultMembers: true, processAnnotatedMembersOnly: true)
class Pku {
  @jsonConstructor
  Pku(this.species, this.personalityValue, this.trainerID);

  @JsonProperty(name: 'Species')
  final String? species;
  @JsonProperty(name: 'Personality Value')
  final int? personalityValue;
  @JsonProperty(name: 'Game Info/Trainer ID')
  final int? trainerID;

  //----------------------------
  // Unmapped values boilerplate
  //----------------------------
  final Map<String, dynamic> _extraPropsMap = {};
  @jsonProperty
  void unmappedSet(String name, dynamic value) {
    _extraPropsMap[name] = value;
  }

  @jsonProperty
  Map<String, dynamic> unmappedGet() {
    return _extraPropsMap;
  }
  //----------------------------

  String toJson({bool prettyPrint = false}) => JsonMapper.serialize(
      this, prettyPrint ? null : const SerializationOptions(indent: ''));

  factory Pku.fromJson(Map<String, dynamic> json) {
    var pku = JsonMapper.deserialize<Pku>(json);
    if (pku == null) throw Exception("pku Parsing exception...");
    return pku;
  }
  factory Pku.fromFile(String path) {
    String rawjson = File(path).readAsStringSync();
    var json = JSON5.parse(rawjson);
    var pku = Pku.fromJson(json);
    dev.log(pku.toJson(prettyPrint: true));
    return pku;
  }
}
