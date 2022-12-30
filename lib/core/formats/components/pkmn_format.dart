import 'dart:typed_data';

abstract class PkmnFormat {
  Uint8List toBytes();
  fromBytes(Uint8List data);
}
