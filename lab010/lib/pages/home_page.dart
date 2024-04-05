import 'package:flutter/material.dart';
import 'package:lab010/db_services.dart';
import '../models/bakery.dart';
import 'package:flutter/widgets.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final DatabaseService _databaseService = DatabaseService();
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  final nameController2 = TextEditingController();
  final priceController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        key: ValueKey('addButton'),
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          _addDialog();
      },),
    );
  }


  PreferredSizeWidget _appBar(){
    return AppBar(
      backgroundColor: Colors.green,
      title: const Text(
        'Bakeries',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUI(){
    return SafeArea(
        child: Column(
      children: [
        _messagesListView(),
      ],
    ));
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _databaseService.getBakeries(),
        builder: (context, snapshot) {
          List bakeries = snapshot.data?.docs ?? [];
          if (bakeries.isEmpty) {
            return Center(
              child: Text('Add a bakery!'),
            );
          }
          return ListView.builder(
            itemCount: bakeries.length,
            itemBuilder: (context, index) {
              Bakery bak = bakeries[index].data();
              String bakId = bakeries[index].id;

              return Draggable(
                feedback: Container(
                  width: MediaQuery.of(context).size.width, // Установите ширину
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.blue[300],
                      title: Text(bak.name),
                      subtitle: Text("Цена: ${bak.price.toString()} у. е."),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              _editDialog(bak, bak.name, bak.price.toString(), bakId);
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              _databaseService.deleteBakery(bakId);
                            },
                            icon: Icon(Icons.delete, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(),
                feedbackOffset: Offset(0, -20),
                child: Card(
                  child: ListTile(
                    tileColor: Colors.green[300],
                    title: Text(bak.name),
                    subtitle: Text("Цена: ${bak.price.toString()} у. е."),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            _editDialog(bak, bak.name, bak.price.toString(), bakId);
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            _databaseService.deleteBakery(bakId);
                          },
                          icon: Icon(Icons.delete, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }


  Future<void> _editDialog(Bakery bak, String name, String price, String bakId) async{

    nameController.text = name ;
    priceController.text = price.toString();

    return showDialog(
        context: context,
        builder:(context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            title: Text('Изменить'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey('addField'),
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: 'Название'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(
                        labelText: 'Цена'
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

                Bakery updatedBakery = bak.copyWith(name: nameController.text.toString(), price: int.parse(priceController.text));
                _databaseService.updateBakery(bakId, updatedBakery);

                nameController.clear();
                priceController.clear();
                Navigator.pop(context);
              }, child: Text('Изменить')),
            ],
          );
        }
    ) ;
  }

  void _addDialog() async{
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          title: const Text('Add bakery'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController2,
                  decoration: const InputDecoration(
                      labelText: 'Название'
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: priceController2,
                  decoration: const InputDecoration(
                      labelText: 'Цена'
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
              Bakery bak = Bakery(name: nameController2.text.toString(), price: int.parse(priceController2.text));
              _databaseService.addBakery(bak);
              priceController2.clear() ;
              nameController2.clear() ;

              Navigator.pop(context);
            }, child: Text('Добавить')),
          ],
        );
      }
    );
  }
}