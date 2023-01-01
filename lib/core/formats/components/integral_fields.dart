import 'package:meta/meta.dart';

import 'fields.dart';

mixin Bounded {
  int? get min;
  int? get max;

  bool _withinRange(int val) =>
      !(min != null && val < min! || max != null && val > max!);

  void _crashIfValNotInRange(int val) {
    if (!_withinRange(val)) {
      throw ArgumentError.value(val, "value must be within [$min, $max].");
    }
  }
}

abstract class IntegralField extends Field<int> with Bounded {
  @protected
  void setValueUnchecked(int val);

  @override
  set value(int val) {
    _crashIfValNotInRange(val);
    setValueUnchecked(val);
  }
}

abstract class IntegralListField extends ListField<int> with Bounded {
  @protected
  void setElementUnchecked(int index, int val);

  @override
  void setElement(int index, int val) {
    _crashIfValNotInRange(val);
    setElementUnchecked(index, val);
  }
}
