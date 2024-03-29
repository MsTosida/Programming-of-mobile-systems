import 'package:flutter/material.dart';
import 'package:lab07_08/task2.dart';
import 'package:lab07_08/task3.dart';
import 'package:lab07_08/task4.dart';
import 'package:lab07_08/task5.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  
  Hive.init(directory.path);

  Hive.registerAdapter(DairyAdapter());
  await Hive.openBox<Dairy>('dairy');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'lab07_08',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}):super(key:key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _controller,
          children: [
            Task2(),
            Task3(),
            Task4(),
            Task5(),
          ],
        )

    );
  }
}
