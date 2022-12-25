// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pku_manager/core/pku_collection/pku_collection_manager.dart';
import 'ui/root_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.mapper.g.dart' show initializeJsonMapper;

final PkuCollectionManager pkucm = PkuCollectionManager();
const String hardCodedCollection = "C:/DummyLocation";

void main() {
  initializeJsonMapper();
  // String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
  pkucm.loadCollection(hardCodedCollection);
  runApp(const ProviderScope(child: RootApp()));
}
