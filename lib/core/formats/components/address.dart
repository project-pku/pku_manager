class ByteAddress {
  final int startBit;
  final int bitLength;
  ByteAddress(int bytes, int byteLength)
      : startBit = bytes * 8,
        bitLength = byteLength * 8;
  ByteAddress.withBits(int startByte, int startBit, this.bitLength)
      : startBit = startByte * 8 + startBit;

  bool isByteLevel() => startBit == 0 && bitLength % 8 == 0;
}
