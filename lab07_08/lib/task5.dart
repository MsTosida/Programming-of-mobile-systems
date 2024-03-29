import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


@HiveType(typeId: 0)
class Dairy extends HiveObject{
  
  @HiveField(0)
  String name;

  @HiveField(1)
  String additives;

  Dairy({required this.name , required this.additives});
}

class DairyAdapter extends TypeAdapter<Dairy> {
  @override
  final int typeId = 0;

  @override
  Dairy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dairy(
      name: fields[0] as String,
      additives: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dairy obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.additives);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DairyAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class Boxes {
  static Box<Dairy> getData() => Hive.box<Dairy>('dairy');
}


class Task5 extends StatefulWidget{
  const Task5({Key? key}):super(key:key);

  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5>{
  final nameController = TextEditingController();
  final additivesController = TextEditingController();


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Task 5'),
      ),
      body: ValueListenableBuilder<Box<Dairy>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context,box ,_){
          var data = box.values.toList().cast<Dairy>();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
                itemCount: box.length,
                reverse: false,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Row(
                              children: [
                                Text(data[index].name.toString() ,
                                  style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500)),
                                Spacer(),
                                InkWell(
                                    onTap: (){
                                      _editDialog(data[index], data[index].name.toString(), data[index].additives.toString());
                                    },
                                    child: Icon(Icons.edit)) ,
                                SizedBox(width: 15,),
                                InkWell(
                                    onTap: (){
                                      delete(data[index]);
                                    },
                                    child: Icon(Icons.delete)),

                              ],
                            ),
                            Text(data[index].additives.toString(),
                              style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(Dairy dairy)async{
    await dairy.delete() ;
  }


  Future<void> _editDialog(Dairy dairy, String name, String additives)async{

    nameController.text = name ;
    additivesController.text = additives ;

    return showDialog(
        context: context,
        builder:(context){
          return AlertDialog(
            title: Text('Изменить'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: 'Название'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: additivesController,
                    decoration: const InputDecoration(
                        labelText: 'Добавки'
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Закрыть')),

              TextButton(onPressed: ()async{

                dairy.name = nameController.text.toString();
                dairy.additives = additivesController.text.toString();

                dairy.save();
                additivesController.clear() ;
                nameController.clear() ;

                Navigator.pop(context);
              }, child: Text('Изменить')),
            ],
          );
        }
    ) ;
  }

  Future<void> _showMyDialog()async{

    return showDialog(
        context: context,
        builder:(context){
          return AlertDialog(
            title: Text('Добавить'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: 'Название'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: additivesController,
                    decoration: const InputDecoration(
                        labelText: 'Добавки'
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Закрыть')),

              TextButton(onPressed: (){
                final data = Dairy(name: nameController.text,
                    additives: additivesController.text) ;

                final box = Boxes.getData();
                box.add(data);

                // data.save() ;

                nameController.clear();
                additivesController.clear();

                // box.

                Navigator.pop(context);
              }, child: Text('Добавить')),
            ],
          );
        }
    ) ;
  }
}