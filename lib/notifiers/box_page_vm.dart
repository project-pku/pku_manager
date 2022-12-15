import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/pku_collection/pku_collection_manager.dart';

class BoxPageVM {
  final PkuCollectionManager pkucm;
  late final BoxPanelInfoStateNotifier boxInfoN;

  BoxPageVM(this.pkucm) {
    boxInfoN = BoxPanelInfoStateNotifier();
    updateState(); //init view
  }

  void updateState() {
    boxInfoN.updateState(
        pkucm.pkuCollection.currentBoxID,
        pkucm.pkuCollection.currentBoxName,
        "pku/OT",
        pkucm.pkuCollection.boxNames);
  }

  void changeBox(int boxNum) {
    pkucm.pkuCollection.currentBoxID = boxNum; //edits model
    updateState(); //updates view
  }
}

class BoxPanelInfoStateNotifier extends StateNotifier<BoxPanelInfoState> {
  BoxPanelInfoStateNotifier() : super(const BoxPanelInfoState._empty());

  void updateState(int currentBoxID, String currentBoxName,
      String collectionName, List<String> boxNames) {
    state = BoxPanelInfoState(
        currentBoxID, currentBoxName, collectionName, boxNames);
  }
}

@immutable
class BoxPanelInfoState {
  final int currentBoxID;
  final String currentBoxName;
  final String collectionName;
  final List<String> boxNames;

  const BoxPanelInfoState(this.currentBoxID, this.currentBoxName,
      this.collectionName, this.boxNames);
  const BoxPanelInfoState._empty() : this(0, "", "", const []);
}
