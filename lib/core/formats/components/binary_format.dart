import 'dart:typed_data';

import 'package:pku_manager/core/binary_util.dart';
import 'package:pku_manager/core/numeric_util.dart';
import 'pkmn_format.dart';
import 'fields.dart';
import 'integral_fields.dart';

abstract class BinaryFormat extends PkmnFormat {
  int get fileSize;
  late final BinaryDataBlock dataBlock = BinaryDataBlock(fileSize);

  @override
  Uint8List toBytes() => dataBlock.data.buffer.asUint8List();
  @override
  fromBytes(Uint8List data) => dataBlock.data = data.buffer.asByteData();
}

class BinaryDataBlock {
  ByteData data;
  int get size => data.lengthInBytes;
  List<BinaryAddress> fields = [];

  BinaryDataBlock(int bytes) : data = ByteData(bytes);
}

mixin BinaryAddress<T> on Field<T>, Bounded {
  BinaryDataBlock get dataBlock;
  int get offset;
  int get bitOffset;
  int get bitLength;
  void registerSelf() => dataBlock.fields.add(this);

  @override
  int get min => 0;
  @override
  int get max => getMaxIntFromBits(bitLength);

  int readValue({int extraBitOffset = 0}) =>
      readBits(dataBlock.data, offset, bitOffset + extraBitOffset, bitLength);

  void writeValue(int val, {int extraBitOffset = 0}) => writeBits(
      dataBlock.data, offset, bitOffset + extraBitOffset, bitLength, val);
}

class BinaryIntField extends IntegralField with BinaryAddress<int> {
  @override
  final BinaryDataBlock dataBlock;
  @override
  final int offset;
  @override
  final int bitOffset;
  @override
  final int bitLength;

  @override
  int get value => readValue();
  @override
  void setValueUnchecked(int val) => writeValue(val);

  BinaryIntField._(
      this.dataBlock, this.offset, this.bitOffset, this.bitLength) {
    registerSelf();
  }

  BinaryIntField(BinaryDataBlock data, int offset, int bytes)
      : this._(data, offset, 0, bytes * 8);

  BinaryIntField.fromBits(
      BinaryDataBlock data, int offset, int bitOffset, int bitLength)
      : this._(data, offset, bitOffset, bitLength);
}

class BinaryIntListField extends IntegralListField with BinaryAddress {
  @override
  final BinaryDataBlock dataBlock;
  @override
  final int offset;
  @override
  final int bitOffset;
  @override
  final int bitLength;

  @override
  final int length;
  @override
  int getElement(int index) => readValue(extraBitOffset: index * bitLength);
  @override
  void setElementUnchecked(int index, int val) =>
      writeValue(val, extraBitOffset: index * bitLength);

  BinaryIntListField._(this.dataBlock, this.offset, this.length, this.bitOffset,
      this.bitLength) {
    registerSelf();
  }

  BinaryIntListField(BinaryDataBlock data, int offset, int bytes, int length)
      : this._(data, offset, length, 0, bytes * 8);

  BinaryIntListField.fromBits(BinaryDataBlock data, int offset, int bitOffset,
      int bitLength, int length)
      : this._(data, offset, length, bitOffset, bitLength);
}

class BinaryBoolField extends Field<bool> with Bounded, BinaryAddress {
  @override
  final BinaryDataBlock dataBlock;
  @override
  final int offset;
  @override
  final int bitOffset;
  @override
  int get bitLength => 1;

  @override
  bool get value => readValue().toBool();
  @override
  set value(bool val) => writeValue(val.toInt());

  BinaryBoolField(this.dataBlock, this.offset, this.bitOffset);
}
