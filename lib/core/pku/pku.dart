import 'dart:io';

import 'package:json5/json5.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pku.g.dart';

@JsonSerializable(constructor: '_uninitialized')
class Pku {
  @JsonKey(name: "Species")
  late final String species;
  @JsonKey(name: "Personality Value")
  late final int? personalityValue;
  @JsonKey(name: "Trainer ID")
  late final int? trainerID;

  Pku._uninitialized(); //for generated code to access object's fields.

  factory Pku.fromJson(Map<String, dynamic> json) => _$PkuFromJson(json);

  factory Pku.fromFile(String path) {
    String rawjson = File(path).readAsStringSync();
    var json = JSON5.parse(rawjson);
    return Pku.fromJson(json);
  }
}
