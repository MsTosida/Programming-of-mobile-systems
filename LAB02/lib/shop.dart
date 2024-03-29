import 'package:lab02/product.dart';

class Beverage extends Product implements IProduct {
  @override
  late int price = 0;
  String name = "bev";
  static int productive = 0;

  Beverage(this.name, this.price) {}

  @override
  void printPrice() {
    print("Напиток $name стоит: $price");
  }

  @override
  void printName() {
    print("Напиток: $name");
  }

  @override
  String toString() {
    return 'Beverage: $name';
  }

  static void Smth() {
    print("This is static method!");
  }
}

class Bakery extends Product implements IProduct {
  @override
  late int price;
  String prodName;

  String get name {
    return prodName;
  }

  void set name(String value) {
    name = "$value $name";
  }

  @override
  void printName() {
    print("Bakery: $name");
  }

  @override
  void printPrice() {
    print("Bakery $name have price: $price");
  }

  Bakery(this.prodName, this.price);
}

class Dairy {
  String ?name;
  String ?additives;

  void Compound(String desc) {
    print("$name consists of $desc");
  }

  void Volume([int count = 250]) {
    print("$name with $additives and have volume $count");
  }

  void DairyName(void Function(String value) printDairyName) {
    printDairyName(name!);
  }

  Dairy.NamedConstructor(this.name, this.additives);
}
