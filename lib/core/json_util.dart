import 'dart:convert';

String prettyPrintJson(Map<String, dynamic> json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  return encoder.convert(json);
}

//TODO: make a json reader util method that ignores comments and trailing commas