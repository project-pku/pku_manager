import 'dart:io';

import 'package:pku_manager/core/pku_collection/pku_collection.dart';

class PkuCollectionManager {
  PkuCollection? _pkuCollection;

  /// Assumes a pkuCollection has been loaded with the [loadCollection] method.
  /// Will crash otherwise...
  PkuCollection get pkuCollection => _pkuCollection!;

  loadCollection(String path) {
    _pkuCollection = PkuCollection(Directory(path));
  }
}
