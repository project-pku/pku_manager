import 'dart:typed_data';

abstract class PkmnFormat {
  Uint8List toBytes();
  void fromBytes(Uint8List data);
}
