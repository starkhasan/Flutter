import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_todo/helper/delete_notes_dialog.dart';
import 'package:notes_todo/helper/empty_message.dart';
import 'package:notes_todo/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:notes_todo/helper/drawer_page.dart';


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

class _MainAppState extends State<MainApp> with WidgetsBindingObserver{

  
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
      drawer: const DrawerPage(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notes',style: TextStyle(fontSize: 16)),
        actions: widget.notesProvider.completedList.isEmpty && widget.notesProvider.listNote.isEmpty
        ? null
        : [IconButton(onPressed: () => deleteNotesDialog(),icon: const Icon(Icons.delete,color: Colors.white,size: 22.0))],
      ),
      floatingActionButton: Visibility(
        visible: widget.notesProvider.fabVisible,
        child: FloatingActionButton(
          backgroundColor: Colors.indigo,
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
                        Visibility(visible: widget.notesProvider.listNote.isNotEmpty,child: Container(margin: const EdgeInsets.only(left: 10,top:15,bottom: 15),child: const Text('Task',style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold)))),
                        notesBody(),
                        Visibility(visible: widget.notesProvider.completedList.isNotEmpty,child: Container(margin: const EdgeInsets.only(left: 10,top:15,bottom: 15),child: const Text('Completed',style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold)))),
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
                    style: const TextStyle(color: Colors.black,fontSize: 15),
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Add Task',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
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
          key: Key(widget.notesProvider.listNote[index]),
          onDismissed: (direction) {
            var item = widget.notesProvider.listNote[index];
            widget.notesProvider.removeTask(widget.notesProvider.listNote[index]);
            showSnackbar(context,item,'$item removed from Task',index,'task');
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 5,top: 5,right: 5),
            margin: const EdgeInsets.only(bottom: 6,left: 15,right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 1)]
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: 1.0,
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.indigo
                    ),
                    child: Checkbox(
                      activeColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      value: widget.notesProvider.selectedTaskIndex == index, 
                      onChanged: (value) => widget.notesProvider.checkedTask(widget.notesProvider.listNote[index],index)
                    )
                  )
                ),
                Expanded(
                  child: Text(widget.notesProvider.listNote[index],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14)),
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
      reverse: true,
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
            showSnackbar(context,item,'$item removed from Complated Task',index,'completeTask');
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 5,top: 5,right: 5),
            margin: const EdgeInsets.only(bottom: 6,left: 15,right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 1)]
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: 1.0,
                  child: Checkbox(
                    activeColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    value: true, 
                    onChanged: (value) => widget.notesProvider.unCheckedCompletedTask(index),
                  ),
                ),
                Expanded(
                  child: Text(widget.notesProvider.completedList[index],style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14))
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

  void showSnackbar(BuildContext context,String item,String message,int index,String type){
    var snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        label: 'UNDO',
        textColor: Colors.yellow,
        onPressed: () => {
          if(type == 'completeTask'){
            widget.notesProvider.undoCompleteTask(item,index)
          }else{
            widget.notesProvider.undoTask(item,index)
          }
        }
      )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  
}
