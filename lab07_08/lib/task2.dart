import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Bakery {
  int? id;
  String? name;
  int? price;

  Bakery({this.id, this.name, this.price});

  // Define a factory method to create a Bakery object from a map
  factory Bakery.fromMap(Map<String, dynamic> map) {
    return Bakery(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }

  // Define a method to convert the Bakery object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('trash.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE bakery(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  price INTEGER
)
''');
  }

  Future<int> createBakery(Bakery bak) async {
    final db = await instance.database;
    return db.insert('bakery', bak.toMap());
  }

  Future<List<Bakery>> readAllBakery() async {
    final db = await instance.database;
    final result = await db.query('bakery');
    return result.map((e) => Bakery.fromMap(e)).toList();
  }

  Future<int> updateBakery(Bakery bak) async {
    final db = await instance.database;
    return db.update('bakery', bak.toMap(),
        where: 'id = ?', whereArgs: [bak.id]);
  }

  Future<int> deleteBakery(int id) async {
    final db = await instance.database;
    return db.delete('bakery', where: 'id = ?', whereArgs: [id]);
  }
}

class Task2 extends StatefulWidget{
  const Task2({Key? key}):super(key:key);

  @override
  _Task2State createState() => _Task2State();
}

class _Task2State extends State<Task2>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 2'),
      ),
      body: FutureBuilder<List<Bakery>>(
        future: DatabaseHelper.instance.readAllBakery(),
        builder: (BuildContext context, AsyncSnapshot<List<Bakery>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final bak = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child:  ListTile(
                    tileColor: Colors.grey[200],
                    title: Text('Название: ${bak.name!}'),
                    subtitle: Text('Цена: ${bak.price}'),
                    //trailing: IconButton(
                      //icon: Icon(Icons.delete),
                      //onPressed: () async {
                      //  await DatabaseHelper.instance.deleteBakery(bak.id!);
                      //  setState(() {});
                     // },
                   // ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            _nameController.text = bak.name!;
                            _priceController.text = bak.price.toString();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Изменить продукт'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          labelText: 'Название',
                                        ),
                                      ),
                                      TextField(
                                        controller: _priceController,
                                        decoration: InputDecoration(
                                          labelText: 'Цена',
                                        ),
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                        ],
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Закрыть'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Изменить'),
                                      onPressed: () async {
                                        final name = _nameController.text;
                                        final price = int.parse(_priceController.text);

                                        bak.name = name;
                                        bak.price = price;

                                        await DatabaseHelper.instance.updateBakery(bak);

                                        setState(() {});

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await DatabaseHelper.instance.deleteBakery(bak.id!);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                );

              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _nameController.text = '';
          _priceController.text = '';
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Добавить выпечку'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Название',
                      ),
                    ),
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Цена',
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Закрыть'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Добавить'),
                    onPressed: () async {
                      final name = _nameController.text;
                      final price = int.parse(_priceController.text);

                      await DatabaseHelper.instance
                          .createBakery(Bakery(name: name, price: price));

                      setState(() {});

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}