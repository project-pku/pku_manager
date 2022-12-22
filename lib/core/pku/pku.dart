import 'dart:io';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:json5/json5.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pku.freezed.dart';
part 'pku.g.dart';

@freezed
class Pku with _$Pku {
  const Pku._();
  const factory Pku(
          {@JsonKey(name: 'Species') String? species,
          @JsonKey(name: 'Personality Value') int? personalityValue,

          //TODO: custom converter that omits empty objects
          @JsonKey(name: 'Game Info') @Default(GameInfo()) GameInfo gameInfo}) =
      _Pku;

  factory Pku.fromJson(Map<String, dynamic> json) => _$PkuFromJson(json);
  factory Pku.fromFile(String path) {
    String rawjson = File(path).readAsStringSync();
    var json = JSON5.parse(rawjson);
    var pku = Pku.fromJson(json);
    dev.log(pku.toJson().toString());
    return pku;
  }
}

@freezed
class GameInfo with _$GameInfo {
  const factory GameInfo(
      {@JsonKey(name: "Trainer ID") int? trainerID,
      @JsonKey(name: "Language") String? language}) = _GameInfo;

  factory GameInfo.fromJson(Map<String, dynamic> json) =>
      _$GameInfoFromJson(json);
}
