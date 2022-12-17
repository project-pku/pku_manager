import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/pku_collection/pku_collection_manager.dart';

class BoxPageVM {
  final PkuCollectionManager pkucm;
  final BoxPanelInfoStateNotifier boxInfoN = BoxPanelInfoStateNotifier();
  final BoxViewStateNotifier boxViewN = BoxViewStateNotifier();
  final SummaryPanelStateNotifier summaryPanelN = SummaryPanelStateNotifier();

  BoxPageVM(this.pkucm) {
    _updateWholePage();
  }

  _updateWholePage() {
    _updateInfoPanelState(); //init view
    _updateBoxViewState(); //update box view
    _updateSummaryPanelState(); //update summary panel
  }

  _updateSummaryPanelState() =>
      summaryPanelN.updateState("", "", "", "", "", "");

  _updateInfoPanelState() => boxInfoN.updateState(
      pkucm.pkuCollection.currentBoxID,
      pkucm.pkuCollection.currentBoxName,
      "pku/OT",
      pkucm.pkuCollection.boxNames);

  _updateBoxViewState() => boxViewN.updateState({
        for (int slot in pkucm.pkuCollection.currentBox.config.slots.keys)
          slot:
              "https://raw.githubusercontent.com/project-pku/pkuSprite/master/util/box/regular/unknown.png"
      });

  changeBox(int boxNum) {
    pkucm.pkuCollection.currentBoxID = boxNum; //edits model
    _updateWholePage();
  }
}

//------------
// BoxPanelInfo
//------------
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

//------------
// BoxView
//------------
class BoxViewStateNotifier extends StateNotifier<BoxViewState> {
  BoxViewStateNotifier() : super(const BoxViewState._empty());

  void updateState(Map<int, String> spriteUrls) {
    state = BoxViewState(spriteUrls);
  }
}

@immutable
class BoxViewState {
  final Map<int, String> spriteUrls;

  const BoxViewState(this.spriteUrls);
  const BoxViewState._empty() : this(const {});
}

//------------
// SummaryPanel
//------------
class SummaryPanelStateNotifier extends StateNotifier<SummaryPanelState> {
  SummaryPanelStateNotifier() : super(const SummaryPanelState._empty());

  void updateState(String nickname, String ot, String originGame,
      String species, String form, String appearance) {
    state =
        SummaryPanelState(nickname, ot, originGame, species, form, appearance);
  }
}

@immutable
class SummaryPanelState {
  final String nickname;
  final String ot;
  final String originGame;
  final String species;
  final String form;
  final String appearance;

  const SummaryPanelState(this.nickname, this.ot, this.originGame, this.species,
      this.form, this.appearance);
  const SummaryPanelState._empty() : this("", "", "", "", "", "");
}
