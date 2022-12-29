import 'dart:math';
import 'fields.dart';

mixin Bounded {
  int? get min;
  int? get max;

  bool _withinRange(int val) =>
      !(min != null && val < min! || max != null && val > max!);

  _crashIfValNotInRange(int val) {
    if (!_withinRange(val)) {
      throw ArgumentError.value(val, "value must be within [$min, $max].");
    }
  }
}

int _getMaxInt(int bits) {
  if (bits > 0 && bits < 64) {
    return pow(2, bits).toInt() - 1;
  } else if (bits == 64) {
    return 9223372036854775807;
  } else {
    throw ArgumentError.value(bits, "n must be an integer from 0 to 64.");
  }
}

class IntegralField extends Field<int> with Bounded {
  @override
  final int? min;
  @override
  final int? max;

  @override
  set value(int x) {
    _crashIfValNotInRange(x);
    super.value = x;
  }

  IntegralField({int value = 0, this.min, this.max}) : super(value) {
    _crashIfValNotInRange(value);
  }

  IntegralField.fromBits(int bits) : this(min: 0, max: _getMaxInt(bits));
  IntegralField.fromBytes(int bytes) : this.fromBits(bytes * 8);
}

class IntegralListField extends ListField<int> with Bounded {
  @override
  final int? min;
  @override
  final int? max;

  @override
  crashIfListInvalid(List<int> value) {
    super.crashIfListInvalid(value);
    for (int x in value) {
      _crashIfValNotInRange(x);
    }
  }

  IntegralListField({List<int>? value, this.min, this.max, super.fixedLength})
      : super(value ??
            (fixedLength != null
                ? List<int>.generate(fixedLength, (i) => 0)
                : const [])) {
    crashIfListInvalid(this.value);
  }

  IntegralListField.fromBits(int bits, {int? fixedLength})
      : this(fixedLength: fixedLength, min: 0, max: _getMaxInt(bits));
  IntegralListField.fromBytes(int bytes, {int? fixedLength})
      : this.fromBits(bytes * 8, fixedLength: fixedLength);
}

class BooleanField extends Field<bool> {
  BooleanField({bool value = false}) : super(value);
}
