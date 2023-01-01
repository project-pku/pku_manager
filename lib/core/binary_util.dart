import 'dart:math';
import 'dart:typed_data';

import 'package:pku_manager/core/numeric_util.dart';
import 'package:tuple/tuple.dart';

const standardBitSizes = <int>{8, 16, 32, 64};
bool _isByteLevel(int bitOffset, int bitLength) =>
    bitOffset == 0 && standardBitSizes.contains(bitLength);

void writeBits(
    ByteData data, int offset, int bitOffset, int bitLength, int value) {
  _isByteLevel(bitOffset, bitLength)
      ? _writeBytes(data, offset, bitLength ~/ 8, value) //byte level
      : _writeBits(data, offset, bitOffset, bitLength, value); //bit level
}

int readBits(ByteData data, int offset, int bitOffset, int bitLength) {
  return _isByteLevel(bitOffset, bitLength)
      ? _readBytes(data, offset, bitLength ~/ 8) //byte level
      : _readBits(data, offset, bitOffset, bitLength); //bit level
}

void _writeBytes(ByteData data, int offset, int length, int value) {
  switch (length) {
    case 1:
      data.setUint8(offset, value);
      break;
    case 2:
      data.setUint16(offset, value);
      break;
    case 4:
      data.setUint32(offset, value);
      break;
    default:
      throw Exception(
          "Writing to ByteAddresses with length $length is not supported.");
  }
}

int _readBytes(ByteData data, int offset, int length) {
  switch (length) {
    case 1:
      return data.getUint8(offset);
    case 2:
      return data.getUint16(offset);
    case 4:
      return data.getUint32(offset);
    default:
      throw Exception(
          "Reading from a ByteAddresses with length $length is not supported.");
  }
}

int _getMask(int bitOffset, int bitLength) =>
    (pow(2, bitLength) - 1).toInt() << bitOffset;

Tuple2<int, int> _normalizeAddress(int offset, int bitOffset) {
  offset += bitOffset ~/ 8;
  bitOffset = bitOffset % 8;
  return Tuple2(offset, bitOffset);
}

int _getValidByteLength(int bitLength) {
  int? validByteLength = (bitLength ~/ 8) + (bitLength > 0 ? 1 : 0);
  validByteLength = findUpperBoundInt(standardBitSizes, validByteLength);
  if (validByteLength == null) {
    throw ArgumentError.value(bitLength, "BitLength must be at most 64");
  }
  return validByteLength;
}

void _writeBits(
    ByteData data, int offset, int bitOffset, int bitLength, int value) {
  var na = _normalizeAddress(offset, bitOffset); //normalize address
  offset = na.item1;
  bitOffset = na.item2;

  //calculate smallest standard byte length
  int validByteLength = _getValidByteLength(bitLength);

  //get enclosing value
  int enclosingVal = _readBytes(data, offset, validByteLength);

  //Calculate new enclosing value
  int mask = _getMask(bitOffset, bitLength); //calculate mask
  enclosingVal = enclosingVal & (~mask); //clear relevant bits
  enclosingVal = enclosingVal | (mask & value << bitOffset); //set relevant bits

  _writeBytes(data, offset, validByteLength, enclosingVal); //write to data
}

int _readBits(ByteData data, int offset, int bitOffset, int bitLength) {
  var na = _normalizeAddress(offset, bitOffset); //normalize address
  offset = na.item1;
  bitOffset = na.item2;

  //calculate smallest standard byte length
  int validByteLength = _getValidByteLength(bitLength);

  //get enclosing value
  int enclosingVal = _readBytes(data, offset, validByteLength);

  int mask = _getMask(bitOffset, bitLength); //calculate mask
  enclosingVal = enclosingVal & mask; //clear irrelevant bits
  return enclosingVal >> bitOffset; //shift relevant bits to 0
}
