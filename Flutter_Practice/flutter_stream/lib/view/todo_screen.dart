import 'package:flutter/material.dart';
import 'package:flutter_stream/bloc/todo_bloc.dart';
import 'package:flutter_stream/model/todo_response.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}
class _TodoScreenState extends State<TodoScreen>{

  var titleController = TextEditingController();
  var completedTask = false;
  final todoBloc = TodoBloc();

  @override
  void dispose() {
    todoBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    todoBloc.fetchTodo();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Todo Screen',style: TextStyle(fontSize: 14))),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title*'
                  )
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(value: completedTask, onChanged: (value) => setState(() => completedTask = value!)),
                    const Text('Task Completed')
                  ]
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(onPressed: () async {
                    var value = await todoBloc.addTodo(context,titleController.text, completedTask);
                    if(value){ titleController.clear();setState(() => completedTask = false );}
                  }, 
                  child: const Text('Submit')),
                )
              ]
            )
          ),
          Expanded(
            child: Container(
              color: Colors.blue[100],
              child: StreamBuilder(
                stream: todoBloc.allTodoResponse,
                builder: (context, snapshot){
                  if(ConnectionState.active == snapshot.connectionState && snapshot.data != null){
                    var data = snapshot.data as List<TodoResponse>;
                    return data.isEmpty
                    ? const Center(child: Text('No Todo Found'))
                    : ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return Card(
                            child: ListTile(
                              title: Text(data[index].title),
                              trailing: IconButton(onPressed: () => todoBloc.deleteTodo(context,index), icon: const Icon(Icons.delete,color: Colors.red)),
                            )
                          );
                        }
                      );
                  }else{
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              )
            )
          )
        ]
      )
    );
  }
}