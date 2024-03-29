abstract class Product {
  void printName() {
  }
}

//interface
interface class IProduct {
  late int price;

  IProduct(this.price);

  void printPrice() {
    print(price);
  }
}