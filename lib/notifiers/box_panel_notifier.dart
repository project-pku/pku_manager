import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/pku_collection/pku_collection_manager.dart';

class BoxPanelNotifier extends StateNotifier<BoxPanelState> {
  final PkuCollectionManager pkucm;

  BoxPanelNotifier(this.pkucm) : super(const BoxPanelState._empty()) {
    updateState();
    pkucm.pkuCollection.addListener(updateState);
  }

  void updateState() {
    state = BoxPanelState(pkucm.pkuCollection.currentBoxName, "pku/OT");
  }
}

@immutable
class BoxPanelState {
  final String boxName;
  final String collectionName;

  const BoxPanelState(this.boxName, this.collectionName);
  const BoxPanelState._empty() : this("", "");
}
