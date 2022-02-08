import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteExample extends StatefulWidget {
  const SQLiteExample({Key? key}) : super(key: key);

  @override
  _SQLiteExampleState createState() => _SQLiteExampleState();
}

class _SQLiteExampleState extends State<SQLiteExample> {

  late Future<Database> database;
  var idController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  List<Dog> listDogs = [];
  var bottonTag = 'Add Dog';
  bool idFieldEnabled = true;

  @override
  void initState() {
    creatingDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('SQLite Example')),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Dog Name'
              )
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                hintText: 'Dog Age'
              )
            ),
            const SizedBox(height: 10),
            TextField(
              controller: idController,
              enabled: idFieldEnabled,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                hintText: 'Dog Id'
              )
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => idFieldEnabled
              ? addDog(context)
              : updateDog(context),
              child: Text(bottonTag)
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listDogs.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: ListTile(
                      title: Text('Name: ${listDogs[index].name}'),
                      subtitle: Text('Age : ${listDogs[index].age.toString()}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () => updateMyDog(listDogs[index]),icon: const Icon(Icons.edit,color: Colors.blue)),
                          IconButton(onPressed: () => deleteDog(listDogs[index].id),icon: const Icon(Icons.delete,color: Colors.red))
                        ]
                      )
                    )
                  );
                }
              ) 
            )
          ]
        )
      )
    );
  }

  addDog(BuildContext context) async{
    if(validation(context)){
      var dog = Dog(id: int.parse(idController.text), name: nameController.text, age: int.parse(ageController.text));
      await insertDog(dog);
    }    
  }

  getAllDogs() async{
    listDogs = await getDogs();
    setState(() {});
  }


  updateMyDog(Dog dog) async{
    setState(() {
      idController.text = dog.id.toString();
      nameController.text = dog.name;
      ageController.text = dog.age.toString();
      bottonTag = 'Update Dog';
      idFieldEnabled = false;
    });
  }

  //Creating Database
  creatingDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      //creating the dog table
      onCreate: (db, version) {
        return db.execute('CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
      }, 
      version: 1
    );
    getAllDogs();
  }

  //Define a function that inserts dogs into the database
  Future<void> insertDog(Dog dog) async {
    final db = await database;
    var data = await db.insert('dogs', dog.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    clearTextField();
    getAllDogs();
  }

  //Reterive all the dogs from  the dog table
  Future<List<Dog>> getDogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (index) {
      return Dog(
        age: maps[index]['age'],
        id: maps[index]['id'],
        name: maps[index]['name']
      );
    });
  }

  //Update a Dog
  Future<void> updateDog(BuildContext context) async{
    if(validation(context)){
      var dog = Dog(id: int.parse(idController.text), name: nameController.text, age: int.parse(ageController.text));
      final db = await database;
      await db.update(
        'dogs', 
        dog.toMap(),
        where: 'id = ?',
        whereArgs: [dog.id]
      );
      bottonTag = 'Add Dog';
      idFieldEnabled = true;
      clearTextField();
      getAllDogs();
    }
  }

  //Delete a Dog
  Future<void> deleteDog(int id) async{
    final db = await database;
    db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id]
    );
    getAllDogs();
  }

  //perform validation
  bool validation(BuildContext context){
    if(idController.text.isEmpty){
      showSnackBar(context, 'Please provide the id');
      return false;
    }else if(nameController.text.isEmpty){
      showSnackBar(context, 'Please provide dog name');
      return false;
    }else if(ageController.text.isEmpty){
      showSnackBar(context, 'Please provide dog age');
      return false;
    }else{
      return true;
    }
  }

  clearTextField(){
    idController.clear();
    nameController.clear();
    ageController.clear();
  }

  //showing SnackBar
  showSnackBar(BuildContext context, String message){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}