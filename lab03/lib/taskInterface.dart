import 'package:lab03/shop.dart';

class Bakery with Product, MProduct implements Comparable<Bakery>{

  Bakery(String prodName, int cost){
    price = cost;
    name = prodName;
  }

  @override
  int compareTo(Bakery bak){
    return price.compareTo(bak.price);
  }
}

class Cheese implements Iterator<Dairy>{
  int _currentIndex = -1;
  List<Dairy> _dairies = [];

  Cheese(List<Dairy> dairies){
    _dairies = dairies;
  }

  @override
  Dairy get current {
    if (_currentIndex < 0 || _currentIndex >= _dairies.length) {
      return Dairy.NamedConstructor(null, null);
    }
    return _dairies[_currentIndex];
  }

  @override
  bool moveNext() {
    _currentIndex++;
    return _currentIndex < _dairies.length;
  }

}



class Yogurt implements Iterable<Dairy>{
  List<Dairy> _dairies = [];

  Yogurt(List<Dairy> dairies) {
    _dairies = dairies;
  }

  @override
  Iterator<Dairy> get iterator {
    return _dairies.iterator;
  }

  @override
  bool any(bool Function(Dairy element) test) {
    for (Dairy element in _dairies) {
      if (test(element)) {
        return true;
      }
    }
    return false;
  }

  @override
  Iterable<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  bool contains(Object? element) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  Dairy elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  bool every(bool Function(Dairy element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Iterable<Dairy> take(int count) {
    var taken = 0;
    var takenDairy = <Dairy>[];
    for (var dairy in _dairies) {
      if (taken == count) {
        break;
      }
      takenDairy.add(dairy);
      taken++;
    }
    return takenDairy;
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(Dairy element) toElements) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  Dairy firstWhere(bool Function(Dairy element) test, {Dairy Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, Dairy element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Iterable<Dairy> followedBy(Iterable<Dairy> other) {
    // TODO: implement followedBy
    throw UnimplementedError();
  }

  @override
  void forEach(void Function(Dairy element) action) {
    // TODO: implement forEach
  }

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement isNotEmpty
  bool get isNotEmpty => throw UnimplementedError();


  @override
  String join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  // TODO: implement last
  Dairy get last => throw UnimplementedError();

  @override
  Dairy lastWhere(bool Function(Dairy element) test, {Dairy Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  // TODO: implement length
  int get length => throw UnimplementedError();

  @override
  Iterable<T> map<T>(T Function(Dairy e) toElement) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  Dairy reduce(Dairy Function(Dairy value, Dairy element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  // TODO: implement single
  Dairy get single => throw UnimplementedError();

  @override
  Dairy singleWhere(bool Function(Dairy element) test, {Dairy Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Iterable<Dairy> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Iterable<Dairy> skipWhile(bool Function(Dairy value) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }



  @override
  Iterable<Dairy> takeWhile(bool Function(Dairy value) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  List<Dairy> toList({bool growable = true}) {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Set<Dairy> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Iterable<Dairy> where(bool Function(Dairy element) test) {
    // TODO: implement where
    throw UnimplementedError();
  }

  @override
  Iterable<T> whereType<T>() {
    // TODO: implement whereType
    throw UnimplementedError();
  }

  @override
  // TODO: implement first
  Dairy get first => throw UnimplementedError();

}
