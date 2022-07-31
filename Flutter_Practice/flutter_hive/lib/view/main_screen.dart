import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //instance of box
  late final Box box;
  //instance of Name TextEditingController()
  var nameController = TextEditingController();
  ///loading flag
  bool isLoading = false;
  /// User Name List
  List<String> nameList = [];

  @override
  void initState() {
    ///get the reference of OpenBox
    box = Hive.box('peopleBox');
    //get user
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        title: const Text('Main Screen'),
        actions: [
          IconButton(onPressed: () => deleteDatabase(), icon: const Icon(Icons.delete, color: Colors.red))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                label: Text('Name')
              ),
              onSubmitted: (value) => addUserName(value),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () => addUserName(nameController.text), child: const Text('Submit')),
            Expanded(
              child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : nameList.isEmpty
                ? const Center(child: Text('No User Found'))
                : ListView.builder(
                  itemCount: nameList.length,
                  itemBuilder: (context, index){
                    return ListTile(title: Text(nameList[index]));
                  }
                )
            )
          ],
        )
      )
    );
  }

  addUserName(String name){
    if(name.isEmpty){
      showSnackBar(context, 'please provide name');
    }else{
      if(nameList.contains(name)){
        showSnackBar(context, 'Name already present');
      } else {
        box.add(name);
        nameController.clear();
        showSnackBar(context, 'Name Added');
        getUser();
      }
    }
  }

  getUser(){
    var data = box.values;
    nameList.clear();
    if(data.isNotEmpty){
      for(var item in data){
        if(!nameList.contains(item)){
          nameList.add(item);
        }
      }
      setState(() {});
    }else {
      setState((){});
    }
  }

  Future<void> deleteDatabase() async {
    //delete all database of the particular box
    await box.clear();
    showSnackBar(context, 'Database Clean');
    getUser();
  }


  @override
  void dispose() {
    // Close all hive boxes
    Hive.close();
    super.dispose();
  }

  showSnackBar(BuildContext context, String message){
    var snackBar = SnackBar(content: Text(message), duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
