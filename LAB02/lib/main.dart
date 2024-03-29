import 'package:flutter/material.dart';
import 'package:lab02/shop.dart';

void main() {
  runApp(const MyApp());

  initProduct();
  initCollections();
  initError();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lab 2'),
    );
  }
}

void initProduct() {
  Beverage Cocke = Beverage("Cocke", 3);
  Cocke.printName();
  Cocke.printPrice();

  Beverage.Smth();
  print(Beverage.productive);

  Bakery Bread = Bakery("Bread", 2);
  Bread.printName();
  Bread.printPrice();

  Dairy cottageCheese = Dairy.NamedConstructor("Cottage cheese", "Vanilla");
  cottageCheese.Compound("Milk, vanilla, sugar");
  cottageCheese.DairyName((value) => print(value));
  cottageCheese.Volume();
  cottageCheese.Volume(500);
}

void initCollections() {
  Beverage Fanta = Beverage("Fanta", 3);
  Beverage Sprite = Beverage("Sprite", 2);
  Beverage Water = Beverage("Water", 1);
  Beverage Coffe = Beverage("Coffe", 1);

  List<Beverage> listBeverages = [Fanta, Sprite, Water];
  listBeverages.add(Water);
  print(listBeverages);

  Set<Beverage> setBeverages = {Sprite, Fanta, Water};
  setBeverages.add(Coffe);
  setBeverages.add(Water);
  print(setBeverages);

  Map<int, Beverage> mapBeverages = {1: Water, 2: Sprite, 3: Fanta};
  mapBeverages.forEach((key, value) {
    print(mapBeverages[key]!.name);
  });

  for (int i = 1; i <= 4; i += 1) {
    if (i == 2) {
      continue;
    }
    if (i == 3) {
      break;
    }
    print(mapBeverages[i]?.name);
  }
}

void initError() {
  try {
    for (int i = 1; i < 10; i++) {
      if (i == 5) {
        throw ErrorDescription("Error");
      }
    }
  } catch (error) {
    print(error);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
