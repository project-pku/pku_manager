import 'package:meta/meta.dart';
import '../json_util.dart';
import 'format_dex.dart';

mixin HasIndexedVals on Dex {
  @protected
  FormatDex get formatDex;
  List<String> indexChain(String format) => formatDex.getIndexChain(format);
}

const blankKey = "\$x";

abstract class Dex {
  @protected
  final JsonMap json;
  Dex(this.json);

  @protected
  T? tryGetValue<T>(List<String> keys, {JsonMap? root}) {
    root ??= json;
    // 0 key
    if (keys.isEmpty && root is T) {
      return root as T;
    }
    // 1 invalid key
    if (!root.containsKey(keys[0])) {
      return null;
    }
    // tunnel down the keys
    dynamic val = root;
    for (String key in keys) {
      val = val[key];
    }
    // return
    if (val is T) {
      return val;
    }
    return null;
  }

  @protected
  List<T>? tryGetList<T>(List<String> keys, {JsonMap? root}) {
    List<dynamic>? listVal = tryGetValue<List>(keys, root: root);
    if (listVal == null) return null;
    if (listVal.every((element) => element is T)) return List<T>.from(listVal);
    return null;
  }

  @protected
  T? tryGetIndexedValue<T>(List<String> indexChain, List<String> keys,
      {JsonMap? root}) {
    //Find indexed value base
    JsonMap? indexRoot = tryGetValue(keys, root: root);

    //try each index in priority order
    for (String index in indexChain) {
      T? indexValue = tryGetValue([index], root: indexRoot);
      if (indexValue is T) return indexValue;
    }
    return null; //none of the indexed values were the right type
  }

  @protected
  String? tryGetIndexedKey<T>(
      List<String> indexChain, List<String> keys, T value,
      {JsonMap? root}) {
    return _tryGetKeyBase(
        keys, (j, k) => tryGetIndexedValue<T>(indexChain, k, root: j) == value,
        root: root);
  }

  @protected
  bool existsIn(String value, String format, {JsonMap? root}) {
    List<String>? existsInList = tryGetList([value, "Exists in"], root: root);
    return existsInList != null && existsInList.contains(format);
  }

  //helper methods
  String? _tryGetKeyBase<T>(
      List<String> keys, bool Function(JsonMap, List<String>) matchFunc,
      {JsonMap? root}) {
    //Check that there is exactly one $x key
    assert(keys.where((key) => key == blankKey).length == 1,
        "keys must have a single '$blankKey' key.");
    //Partition keys on $x
    int splitIndex = keys.indexOf(blankKey);
    List<String> firstHalf = keys.take(splitIndex).toList();
    List<String> secondHalf = keys.skip(splitIndex).toList();

    //traverse first half
    JsonMap? fhRoot = tryGetValue(firstHalf, root: root);
    if (fhRoot == null) return null; //first half doesnt even exist

    //traverse second half
    for (String key in fhRoot.keys) {
      secondHalf[0] = key;
      if (matchFunc(fhRoot, secondHalf)) {
        return key; //found key
      }
    }
    return null; //no matching key
  }
}
