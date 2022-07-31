import 'package:flutter/material.dart';
import 'package:navigation_route/controller/home_controller.dart';
import 'package:navigation_route/model/todo_response.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    homeController.getTodo();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Todo')),
      body: StreamBuilder<List<TodoResponse>>(
        stream: homeController.todoStream,
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.connectionState == ConnectionState.active && snapshot.data != null){
            var data = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              padding: const EdgeInsets.only(bottom: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5)),boxShadow: [BoxShadow(blurRadius: 0.5,color: Colors.grey)]),
                  child: Row(
                    children: [
                      Checkbox(value: data[index].completed, onChanged: (value) => homeController.completeTask(index, value)),
                      const SizedBox(width: 10),
                      Flexible(child: Text(data[index].title))
                    ],
                  ),
                );
              },
            );
          } else{
            return const Center(child: Text('No Item Found'));
          }
        }
      )
    );
  }
}
