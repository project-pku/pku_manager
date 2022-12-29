import 'package:meta/meta.dart';

abstract class Field<T> {
  T value;
  Field(this.value);
}

abstract class ListField<T> extends Field<List<T>> {
  int? fixedLength;

  @protected
  crashIfListInvalid(List<T> value) {
    if (value.length != fixedLength) {
      throw ArgumentError.value(value,
          "The number of elements in this field must equal $fixedLength");
    }
  }

  @override
  set value(List<T> value) {
    crashIfListInvalid(value);
    super.value = value;
  }

  ListField(super.value, {this.fixedLength}) {
    crashIfListInvalid(value);
  }
  operator [](index) => value[index];
}
