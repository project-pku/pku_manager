import 'components/binary_format.dart';

class Pk3 extends BinaryFormat {
  @override
  int get fileSize => 80;

  // Address constants
  static const int blockSize = 12;
  static const int gOffest = 32;
  static const int aOffest = gOffest + blockSize;
  static const int eOffest = aOffest + blockSize;
  static const int mOffest = eOffest + blockSize;

  // Non-Block
  late final BinaryIntField pid = BinaryIntField(dataBlock, 0, 4);
  late final BinaryIntField tid = BinaryIntField(dataBlock, 4, 4);
  late final BinaryIntListField nickname =
      BinaryIntListField(dataBlock, 8, 1, 10);
  late final BinaryIntField language = BinaryIntField(dataBlock, 18, 1);
  late final BinaryBoolField isBadEgg = BinaryBoolField(dataBlock, 19, 0);
  late final BinaryBoolField hasSpecies = BinaryBoolField(dataBlock, 19, 1);
  late final BinaryBoolField useEggName = BinaryBoolField(dataBlock, 19, 2);
  //5 padding bits
  late final BinaryIntListField ot = BinaryIntListField(dataBlock, 20, 1, 7);
  late final BinaryBoolField markingCircle = BinaryBoolField(dataBlock, 27, 0);
  late final BinaryBoolField markingSquare = BinaryBoolField(dataBlock, 27, 1);
  late final BinaryBoolField markingTriangle =
      BinaryBoolField(dataBlock, 27, 2);
  late final BinaryBoolField markingHeart = BinaryBoolField(dataBlock, 27, 3);
  //4 padding bits
  late final BinaryIntField checksum = BinaryIntField(dataBlock, 28, 1);

  /// For valid Pokémon, should always be 0
  late final BinaryIntField sanity = BinaryIntField(dataBlock, 30, 1);

  // Block G
  late final BinaryIntField species = BinaryIntField(dataBlock, gOffest + 0, 1);
  late final BinaryIntField item = BinaryIntField(dataBlock, gOffest + 2, 1);
  late final BinaryIntField experience =
      BinaryIntField(dataBlock, gOffest + 4, 4);
  late final BinaryIntListField ppUps =
      BinaryIntListField.fromBits(dataBlock, gOffest + 8, 0, 2, 4);
  late final BinaryIntField friendship =
      BinaryIntField(dataBlock, gOffest + 9, 1);
  //2 padding bytes

  // Block A
  late final BinaryIntListField moves =
      BinaryIntListField(dataBlock, aOffest + 0, 2, 4);
  late final BinaryIntListField pp =
      BinaryIntListField(dataBlock, aOffest + 8, 1, 4);

  // Block E
  late final BinaryIntListField evs =
      BinaryIntListField(dataBlock, aOffest + 0, 1, 6);
  late final BinaryIntListField contestStats =
      BinaryIntListField(dataBlock, aOffest + 6, 1, 6);

  // Block M
  late final BinaryIntField pokerusDays =
      BinaryIntField.fromBits(dataBlock, mOffest + 0, 0, 4);
  late final BinaryIntField pokerusStrain =
      BinaryIntField.fromBits(dataBlock, mOffest + 0, 4, 4);

  late final BinaryIntField metLocation =
      BinaryIntField(dataBlock, mOffest + 1, 1);
  late final BinaryIntField metLevel =
      BinaryIntField.fromBits(dataBlock, mOffest + 2, 0, 7);
  late final BinaryIntField originGame =
      BinaryIntField.fromBits(dataBlock, mOffest + 2, 7, 4);
  late final BinaryIntField ball =
      BinaryIntField.fromBits(dataBlock, mOffest + 2, 11, 4);
  late final BinaryBoolField otGender =
      BinaryBoolField(dataBlock, mOffest + 2, 15);

  late final BinaryIntListField ivs =
      BinaryIntListField.fromBits(dataBlock, mOffest + 4, 0, 5, 6);
  late final BinaryBoolField isEgg =
      BinaryBoolField(dataBlock, mOffest + 4, 30);
  late final BinaryBoolField ability =
      BinaryBoolField(dataBlock, mOffest + 4, 31);

  late final BinaryIntListField contestRibbons =
      BinaryIntListField.fromBits(dataBlock, mOffest + 8, 0, 3, 5);
  late final BinaryBoolField ribbonChampion =
      BinaryBoolField(dataBlock, mOffest + 8, 15);
  late final BinaryBoolField ribbonWinning =
      BinaryBoolField(dataBlock, mOffest + 8, 16);
  late final BinaryBoolField ribbonVictory =
      BinaryBoolField(dataBlock, mOffest + 8, 17);
  late final BinaryBoolField ribbonArtist =
      BinaryBoolField(dataBlock, mOffest + 8, 18);
  late final BinaryBoolField ribbonEffort =
      BinaryBoolField(dataBlock, mOffest + 8, 19);
  late final BinaryBoolField ribbonBattleChampion =
      BinaryBoolField(dataBlock, mOffest + 8, 20);
  late final BinaryBoolField ribbonRegionalChampion =
      BinaryBoolField(dataBlock, mOffest + 8, 21);
  late final BinaryBoolField ribbonNationalChampion =
      BinaryBoolField(dataBlock, mOffest + 8, 22);
  late final BinaryBoolField ribbonCountry =
      BinaryBoolField(dataBlock, mOffest + 8, 23);
  late final BinaryBoolField ribbonNational =
      BinaryBoolField(dataBlock, mOffest + 8, 24);
  late final BinaryBoolField ribbonEarth =
      BinaryBoolField(dataBlock, mOffest + 8, 25);
  late final BinaryBoolField ribbonWorld =
      BinaryBoolField(dataBlock, mOffest + 8, 26);
  //4 padding bits
  late final BinaryBoolField fatefulEncounter =
      BinaryBoolField(dataBlock, mOffest + 8, 31);
}
