import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task3 extends StatefulWidget{
  const Task3({Key? key}):super(key:key);

  @override
  _Task3State createState() => _Task3State();
}

class _Task3State extends State<Task3>{

  final _keyController = TextEditingController();
  final _valueController = TextEditingController();

  String? _value;
  List<String> _keyValuePairs = [];

  Future<void> _saveData() async {
    final key = _keyController.text;
    final value = _valueController.text;

    if (key.isNotEmpty && value.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    }
  }

  Future<void> _readData() async {
    final prefs = await SharedPreferences.getInstance();
    final allPrefs = prefs.getKeys();
    setState(() {
      _keyValuePairs = allPrefs.map((key) => '$key: ${prefs.getString(key)}').toList();
    });
  }

  Future<void> _deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyController.text);
   //await _readData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 3'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _keyController,
              decoration: InputDecoration(
                labelText: 'Ключ',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
            ),
            TextField(
              controller: _valueController,
              decoration: InputDecoration(
                labelText: 'Значение',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveData,
                  child: Text('Create'),
                ),
                ElevatedButton(
                  onPressed: _readData,
                  child: Text('Read'),
                ),
                ElevatedButton(
                  onPressed: _deleteData,
                  child: Text('Delete'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
                'Пары:',
                style: TextStyle(
                  fontSize: 20, // Размер шрифта
                  fontWeight: FontWeight.bold,
                )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _keyValuePairs.map((pair) => Text(pair)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}