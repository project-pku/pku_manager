import 'components/pkmn_data.dart';
import 'components/address.dart';
import 'components/fields.dart';
import 'components/integral_fields.dart';

class Pk3 extends PkmnFormat with BinaryFormat {
  @override
  final int fileSize = 80;

  // Non-Block
  final IntegralField pid = IntegralField.fromBytes(4);
  final IntegralField tid = IntegralField.fromBytes(4);
  final IntegralListField nickname =
      IntegralListField.fromBytes(1, fixedLength: 10);
  final IntegralField language = IntegralField.fromBytes(1);
  final BooleanField isBadEgg = BooleanField();
  final BooleanField hasSpecies = BooleanField();
  final BooleanField useEggName = BooleanField();
  final IntegralListField ot = IntegralListField.fromBytes(1, fixedLength: 7);
  final BooleanField markingCircle = BooleanField();
  final BooleanField markingSquare = BooleanField();
  final BooleanField markingTriangle = BooleanField();
  final BooleanField markingHeart = BooleanField();
  final IntegralField checksum = IntegralField.fromBytes(2);

  /// For valid Pokémon, should always be 0
  final IntegralField sanity = IntegralField.fromBytes(2);

  // Block G
  final IntegralField species = IntegralField.fromBytes(2);
  final IntegralField item = IntegralField.fromBytes(2);
  final IntegralField experience = IntegralField.fromBytes(4);
  final IntegralListField ppUps = IntegralListField.fromBits(2, fixedLength: 4);
  final IntegralField friendship = IntegralField.fromBytes(1);

  // Block A
  final IntegralListField moves =
      IntegralListField.fromBytes(2, fixedLength: 4);
  final IntegralListField pp = IntegralListField.fromBytes(1, fixedLength: 4);

  // Block E
  final IntegralListField evs = IntegralListField.fromBytes(1, fixedLength: 6);
  final IntegralListField contestStats =
      IntegralListField.fromBytes(1, fixedLength: 6);

  // Block M
  final IntegralField pokerusDays = IntegralField.fromBits(4);
  final IntegralField pokerusStrain = IntegralField.fromBits(4);

  final IntegralField metLocation = IntegralField.fromBytes(1);
  final IntegralField metLevel = IntegralField.fromBits(7);
  final IntegralField originGame = IntegralField.fromBits(4);
  final IntegralField ball = IntegralField.fromBits(4);
  final BooleanField otGender = BooleanField();

  final IntegralListField ivs = IntegralListField.fromBits(5, fixedLength: 6);
  final BooleanField isEgg = BooleanField();
  final BooleanField ability = BooleanField();

  final IntegralListField contestRibbons =
      IntegralListField.fromBits(3, fixedLength: 5);
  final BooleanField ribbonChampion = BooleanField();
  final BooleanField ribbonWinning = BooleanField();
  final BooleanField ribbonVictory = BooleanField();
  final BooleanField ribbonArtist = BooleanField();
  final BooleanField ribbonEffort = BooleanField();
  final BooleanField ribbonBattleChampion = BooleanField();
  final BooleanField ribbonRegionalChampion = BooleanField();
  final BooleanField ribbonNationalChampion = BooleanField();
  final BooleanField ribbonCountry = BooleanField();
  final BooleanField ribbonNational = BooleanField();
  final BooleanField ribbonEarth = BooleanField();
  final BooleanField ribbonWorld = BooleanField();

  final BooleanField fatefulEncounter = BooleanField();

  // Address Map
  static const int blockSize = 12;
  static const int gOffest = 32;
  static const int aOffest = gOffest + blockSize;
  static const int eOffest = aOffest + blockSize;
  static const int mOffest = eOffest + blockSize;

  @override
  late final Map<ByteAddress, Field> addressMap = {
    ByteAddress(0, 4): pid,
    ByteAddress(4, 4): tid,
    ByteAddress(8, 1 * 10): nickname,
    ByteAddress(18, 1): language,
    ByteAddress.withBits(19, 0, 1): isBadEgg,
    ByteAddress.withBits(19, 1, 1): hasSpecies,
    ByteAddress.withBits(19, 2, 1): useEggName,
    //5 padding bits
    ByteAddress(20, 1 * 7): ot,
    ByteAddress.withBits(27, 0, 1): markingCircle,
    ByteAddress.withBits(27, 0, 1): markingSquare,
    ByteAddress.withBits(27, 0, 1): markingTriangle,
    ByteAddress.withBits(27, 0, 1): markingHeart,
    //4 padding bits
    ByteAddress(28, 2): checksum,
    ByteAddress(30, 2): sanity,

    //G block
    ByteAddress(gOffest + 0, 2): species,
    ByteAddress(gOffest + 2, 2): item,
    ByteAddress(gOffest + 4, 4): experience,
    ByteAddress(gOffest + 8, 1): ppUps, //2 bits * 4 = 1 byte
    ByteAddress(gOffest + 9, 1): friendship,
    //2 padding bytes

    //A Block
    ByteAddress(aOffest + 0, 2 * 4): moves,
    ByteAddress(aOffest + 8, 1 * 4): pp,

    //E Block
    ByteAddress(aOffest + 0, 1 * 6): evs,
    ByteAddress(aOffest + 6, 1 * 6): contestStats,

    //M Block
    ByteAddress.withBits(mOffest + 0, 0, 4): pokerusDays,
    ByteAddress.withBits(mOffest + 0, 4, 4): pokerusStrain,
    ByteAddress(mOffest + 1, 1): metLocation,
    ByteAddress.withBits(mOffest + 2, 0, 7): metLevel,
    ByteAddress.withBits(mOffest + 2, 7, 4): originGame,
    ByteAddress.withBits(mOffest + 2, 11, 4): ball,
    ByteAddress.withBits(mOffest + 2, 15, 1): otGender,
    ByteAddress.withBits(mOffest + 4, 0, 5 * 6): ivs,
    ByteAddress.withBits(mOffest + 4, 30, 1): isEgg,
    ByteAddress.withBits(mOffest + 4, 31, 1): ability,
    ByteAddress.withBits(mOffest + 8, 0, 3 * 5): contestRibbons,
    ByteAddress.withBits(mOffest + 8, 15, 1): ribbonChampion,
    ByteAddress.withBits(mOffest + 8, 16, 1): ribbonWinning,
    ByteAddress.withBits(mOffest + 8, 17, 1): ribbonVictory,
    ByteAddress.withBits(mOffest + 8, 18, 1): ribbonArtist,
    ByteAddress.withBits(mOffest + 8, 19, 1): ribbonEffort,
    ByteAddress.withBits(mOffest + 8, 20, 1): ribbonBattleChampion,
    ByteAddress.withBits(mOffest + 8, 21, 1): ribbonRegionalChampion,
    ByteAddress.withBits(mOffest + 8, 22, 1): ribbonNationalChampion,
    ByteAddress.withBits(mOffest + 8, 23, 1): ribbonCountry,
    ByteAddress.withBits(mOffest + 8, 24, 1): ribbonNational,
    ByteAddress.withBits(mOffest + 8, 25, 1): ribbonEarth,
    ByteAddress.withBits(mOffest + 8, 26, 1): ribbonWorld,
    //4 padding bits
    ByteAddress.withBits(mOffest + 8, 31, 1): fatefulEncounter,
  };
}
