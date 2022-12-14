import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/pku_collection/pku_collection_manager.dart';

class BoxPageVM {
  final PkuCollectionManager pkucm;
  late final BoxInfoStateNotifier boxInfoN;

  BoxPageVM(this.pkucm) {
    boxInfoN = BoxInfoStateNotifier();
    updateState(); //init view
  }

  void updateState() {
    boxInfoN.updateState(pkucm.pkuCollection.currentBoxName, "pku/OT");
  }

  void changeBox(int boxNum) {
    pkucm.pkuCollection.currentBoxID = boxNum; //edits model
    updateState(); //updates view
  }
}

@immutable
class BoxListState {
  final List<String> boxNames;

  const BoxListState(this.boxNames);
}

class BoxInfoStateNotifier extends StateNotifier<BoxInfoState> {
  BoxInfoStateNotifier() : super(const BoxInfoState._empty());

  void updateState(String currentBoxName, String collectionName) {
    state = BoxInfoState(currentBoxName, collectionName);
  }
}

@immutable
class BoxInfoState {
  final String currentBoxName;
  final String collectionName;

  const BoxInfoState(this.currentBoxName, this.collectionName);
  const BoxInfoState._empty() : this("", "");
}
