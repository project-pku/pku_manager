import 'dex.dart';

class FormatDex extends Dex {
  FormatDex(super.json);

  List<String> getIndexChain(String format) {
    List<String> chain = [format];
    List<String>? formatParents =
        tryGetList<String>([format, "Parent Indices"]);
    if (formatParents != null) {
      chain.addAll(formatParents);
    }
    return chain;
  }
}
