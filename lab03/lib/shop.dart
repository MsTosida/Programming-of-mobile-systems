mixin class Product {
  late String name;
  void printName() {
    print("Name is $name");
  }

}

mixin MProduct {
  late int price;

  void printPrice() {
    print("Price is $price");
  }
}

class Beverage with Product, MProduct {
  @override
  static int productive = 0;

  Beverage(String title, int cost) {
    price = cost;
    name = title;
  }

  @override
  String toString() {
    return 'Beverage: $name';
  }

  static void Smth() {
    print("The best drinks are only here!");
  }
}

class Dairy{
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

  @override
  String toString() {
    return 'Dairy(name: $name, additives: $additives)';
  }

}


// Сериализация в Json
class Employee {
  String name;
  String jobTitle;
  int age;

  Employee(this.name, this.age, this.jobTitle);

  Map<String, dynamic> toJSON() => {
    'name': name,
    'age': age,
    'jobTitle': jobTitle,
  };

  Employee fromJSON(Map<String, dynamic> json) {
    Employee employeeFromJSON = Employee("", 0, "");
    employeeFromJSON.name = json['name'];
    employeeFromJSON.age = json['age'];
    employeeFromJSON.jobTitle = json['jobTitle'];
    return employeeFromJSON;
  }
}