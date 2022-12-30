import 'package:meta/meta.dart';

abstract class Field<T> {
  T get value;
  set value(T val);
}

abstract class ListField<T> extends Field<List<T>> {
  int get length;

  @protected
  T getElement(int index);
  @protected
  void setElement(int index, T val);

  @override
  List<T> get value {
    List<T> temp = [];
    for (int i = 0; i < length; i++) {
      temp.add(getElement(i));
    }
    return temp;
  }

  @override
  set value(List<T> vals) {
    for (int i = 0; i < length; i++) {
      setElement(i, vals[i]);
    }
  }

  operator [](index) => getElement(index);
  operator []=(index, val) => setElement(index, val);
}
