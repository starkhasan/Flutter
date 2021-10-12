import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_todo/helper/delete_notes_dialog.dart';
import 'package:notes_todo/helper/empty_message.dart';
import 'package:notes_todo/providers/notes_provider.dart';
import 'package:notes_todo/utils/helpers.dart';

import 'package:provider/provider.dart';


class NotesPage extends StatelessWidget {
  const NotesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: Consumer<NotesProvider>(
        builder: (context,provider,child){
          return MainApp(notesProvider: provider);
        }
      ),
    );
  }
}


class MainApp extends StatefulWidget {
  final NotesProvider notesProvider;
  const MainApp({ Key? key,required this.notesProvider}) : super(key: key);
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver,Helpers{

  
  late FocusNode focusNode;
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    focusNode.dispose();
    super.dispose();
  }


  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance!.window.viewInsets.bottom;
    if(bottomInset == 0.0){
      widget.notesProvider.fabAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notes'),
        actions: widget.notesProvider.completedList.isEmpty && widget.notesProvider.listNote.isEmpty
        ? null
        : [IconButton(onPressed: () => deleteNotesDialog(),icon: const Icon(Icons.delete,color: Colors.white))],
      ),
      floatingActionButton: Visibility(
        visible: widget.notesProvider.fabVisible,
        child: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () => {
            focusNode.hasFocus
            ? focusNode.unfocus()
            : {
              widget.notesProvider.fabAction(),
              focusNode.requestFocus()
            }
          },
          child: const Icon(Icons.add,color: Colors.white),
        )
      ),
      body: Container(
        color:Colors.white,
        child: Stack(
          children: [ 
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(visible: widget.notesProvider.listNote.isNotEmpty,child: Container(margin: const EdgeInsets.only(left: 10,top:15,bottom: 15),child: const Text('Task',style: TextStyle(color: Colors.teal,fontSize: 20,fontWeight: FontWeight.bold)))),
                        notesBody(),
                        Visibility(visible: widget.notesProvider.completedList.isNotEmpty,child: Container(margin: const EdgeInsets.only(left: 10,top:15,bottom: 15),child: const Text('Completed',style: TextStyle(color: Colors.teal,fontSize: 20,fontWeight: FontWeight.bold)))),
                        completedNotes()
                      ]
                    )
                  )
                )
              ]
            ),
            Align(
              alignment: Alignment.center,
              child: Visibility(
                visible: widget.notesProvider.completedList.isEmpty && widget.notesProvider.listNote.isEmpty,
                child: const EmptyMessage()
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: widget.notesProvider.taskContainerVisible,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Color(0xFFBDBDBD))),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFBDBDBD),
                        blurRadius: 5.0,
                        offset: Offset(0, 0),
                      )
                    ]
                  ),
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: textController,
                    focusNode: focusNode,
                    minLines: 1,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(color: Colors.black,fontSize: 18),
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Add Task',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 16)
                    ),
                    onEditingComplete: (){
                      if(textController.text.isNotEmpty){
                        widget.notesProvider.addTask(textController.text);
                        textController.clear();
                      }
                    }
                  )
                )
              )
            )
          ]
        )
      )
    );
  }


  Widget notesBody(){
    var listItem = widget.notesProvider.listNote.keys;
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      itemCount: widget.notesProvider.listNote.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context,int index){
        return Dismissible(
          secondaryBackground: Container(color: Colors.red,padding: const EdgeInsets.only(right: 20),alignment: Alignment.centerRight,child: const Icon(Icons.delete,color: Colors.white)),
          background: Container(color: Colors.white),
          direction: DismissDirection.endToStart,
          key: Key(listItem.elementAt(index)),
          onDismissed: (direction) {
            var item = listItem.elementAt(index);
            widget.notesProvider.removeTask(listItem.elementAt(index));
            showSnackBar(context, '$item removed from task');
          },
          child: Container(
            padding: const EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 8),
            margin: const EdgeInsets.only(bottom: 7,left: 15,right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 1)]
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.teal
                    ),
                    child: Checkbox(
                      activeColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      value: widget.notesProvider.listNote[listItem.elementAt(index)], 
                      onChanged: (value) => widget.notesProvider.checkedTask(listItem.elementAt(index))
                    )
                  )
                ),
                Expanded(
                  child: Text(listItem.elementAt(index),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16)),
                )
              ]
            )
          )
        );
      }
    );
  }

  Widget completedNotes(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.notesProvider.completedList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context,int index){
        return Dismissible(
          secondaryBackground: Container(color: Colors.red,padding: const EdgeInsets.only(right: 20),alignment: Alignment.centerRight,child: const Icon(Icons.delete,color: Colors.white)),
          background: Container(color: Colors.red),
          direction: DismissDirection.endToStart,
          key: Key(widget.notesProvider.completedList[index]),
          onDismissed: (direction){
            var item = widget.notesProvider.completedList[index];
            widget.notesProvider.removeCompletedTask(item);
            showSnackBar(context, '$item removed from complated');
          },
          child: Container(
            padding: const EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 8),
            margin: const EdgeInsets.only(bottom: 7,left: 15,right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 2)]
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    activeColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    value: true, 
                    onChanged: (value) => widget.notesProvider.checkedCompletedTask(index),
                  ),
                ),
                Expanded(
                  child: Text(widget.notesProvider.completedList[index],style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16))
                )
              ]
            )
          )
        );
      }
    );
  }

  deleteNotesDialog(){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return DeleteNotesDialog(
          onPressed: () => {
            widget.notesProvider.deleteAllNotes(),
            Navigator.pop(context)
          }
        );
      }
    );
  }
  
}
