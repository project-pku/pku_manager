import 'dart:math';

extension IntCasting on bool {
  int toInt() => this ? 1 : 0;
}

extension BoolCasting on int {
  bool toBool() => this > 0 ? true : false;
}

int getMaxIntFromBits(int bits) {
  if (bits > 0 && bits < 64) {
    return pow(2, bits).toInt() - 1; //i.e. 2^bits-1
  } else if (bits == 64) {
    return 9223372036854775807; //i.e. 2^64-1
  } else {
    throw ArgumentError.value(bits, "n must be an integer from 0 to 64.");
  }
}

T? findUpperBound<T extends Comparable<T>>(Set<T> bounds, T val) {
  T? largestSoFar;
  for (T bound in bounds) {
    if (largestSoFar != null && largestSoFar.compareTo(bound) >= 0) {
      continue;
    }
    if (val.compareTo(bound) < 0) largestSoFar = bound;
  }
  return largestSoFar;
}

int? findUpperBoundInt(Set<int> bounds, int val) =>
    findUpperBound<num>(bounds, val)?.toInt();
