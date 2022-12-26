import 'dart:io';
import 'dart:developer' as dev;

import 'package:json5/json5.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(ignoreDefaultMembers: true, processAnnotatedMembersOnly: true)
class Pku {
  //----------------------------
  // Properties
  //----------------------------

  //Permanent Stuff
  @JsonProperty(name: 'Species')
  final String? species;
  @JsonProperty(name: 'Forms')
  final List<String>? forms;
  @JsonProperty(name: 'Nickname')
  final String? nickname;
  @JsonProperty(name: 'Original Trainer')
  final String? ot;
  @JsonProperty(name: 'Trainer ID')
  final String? tid;
  @JsonProperty(name: 'Personality Value')
  final int? pid;

  //Core changeable
  @JsonProperty(name: 'Item')
  final String? item;
  @JsonProperty(name: 'Experience')
  final int? experience;
  @JsonProperty(name: 'Friendship')
  final int? friendship;
  @JsonProperty(name: 'Markings')
  final List<String>? markings;

  //Game Info
  @JsonProperty(name: 'Game Info/Original Trainer')
  final int? gameOT;
  @JsonProperty(name: 'Game Info/Trainer ID')
  final int? gameTid;

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
  // Serialization
  //----------------------------
  String toJson({bool prettyPrint = false}) => JsonMapper.serialize(
      this, prettyPrint ? null : const SerializationOptions(indent: ''));

  factory Pku.fromJson(Map<String, dynamic> json) {
    var pku = JsonMapper.deserialize<Pku>(json);
    if (pku == null) throw Exception("pku Parsing exception...");
    return pku;
  }

  //----------------------------
  // Constructors
  //----------------------------
  factory Pku.fromFile(String path) {
    String rawjson = File(path).readAsStringSync();
    var json = JSON5.parse(rawjson);
    var pku = Pku.fromJson(json);
    dev.log("$path: ${pku.toJson(prettyPrint: false)}");
    return pku;
  }

  @jsonConstructor
  Pku(
      this.species,
      this.forms,
      this.nickname,
      this.ot,
      this.tid,
      this.pid,
      this.item,
      this.experience,
      this.friendship,
      this.markings,
      this.gameOT,
      this.gameTid);
}
