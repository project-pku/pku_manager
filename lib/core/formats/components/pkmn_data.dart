import 'dart:typed_data';

import 'address.dart';
import 'fields.dart';

abstract class PkmnFormat {
  Uint8List toBytes();
}

mixin BinaryFormat {
  int get fileSize;
  Map<ByteAddress, Field> get addressMap;
  Uint8List toBytes() {
    var data = ByteData(fileSize);
    for (var kvp in addressMap.entries) {
      var addr = kvp.key;
      var field = kvp.value;
      if (addr.isByteLevel()) {
        _writeBytes(data, addr.startBit * 8, addr.bitLength % 8, field.value);
      } else {
        _writeBits(data, addr.startBit, addr.bitLength, field.value);
      }
    }
    return data.buffer.asUint8List();
  }

  _writeBytes(ByteData data, int startByte, int byteLength, int value) {}
  _writeBits(ByteData data, int startBit, int bitLength, int value) {}
}
