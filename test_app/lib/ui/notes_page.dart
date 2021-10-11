  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({ Key? key }) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with WidgetsBindingObserver{

  Map<String,bool> listNote = {
    'Marketing' : false,
    'Submit Tution Fee': false,
    'Submit Electricity Bill': false,
    'Submit Internet Bill':false,
    'Submit Gas Bill': false,
    'Order a new Mouse': false,
    'Design New UI of Deliver Application': false
  };

  late FocusNode focusNode;
  bool fabVisible = true;
  bool taskContainerVisible = false;
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
      setState(() {
        fabVisible = true;
        taskContainerVisible = false;
      });
    }
  }
  
  var completedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.pop(context),icon: const Icon(Icons.arrow_back,color: Colors.black)),
        centerTitle: true,
        title: const Text('Notes',style: TextStyle(color: Colors.black))
      ),
      floatingActionButton: Visibility(
        visible: fabVisible,
        child: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () => {
            focusNode.hasFocus
            ? focusNode.unfocus()
            : {
              taskContainerVisible = true,
              setState(() => fabVisible = false),
              focusNode.requestFocus()
            }
          },
          child: const Icon(Icons.add,color: Colors.white),
        ),
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
                        Visibility(visible: listNote.isNotEmpty,child: Container(margin: const EdgeInsets.only(left: 10,top:15,bottom: 15),child: const Text('Task',style: TextStyle(color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold)))),
                        notesBody(),
                        Visibility(visible: completedList.isNotEmpty,child: Container(margin: const EdgeInsets.only(left: 10,top:15,bottom: 15),child: const Text('Completed',style: TextStyle(color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold)))),
                        completedNotes()
                      ]
                    )
                  )
                )
              ]
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: taskContainerVisible,
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
                    textInputAction: TextInputAction.send,
                    style: const TextStyle(color: Colors.black,fontSize: 18),
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Add Task',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 16)
                    ),
                    onEditingComplete: (){
                      if(textController.text.isNotEmpty){
                        setState(() {listNote[textController.text] = false;});
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
    var listItem = listNote.keys;
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      itemCount: listNote.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context,int index){
        return Dismissible(
          secondaryBackground: Container(color: Colors.red,padding: const EdgeInsets.only(right: 20),alignment: Alignment.centerRight,child: const Icon(Icons.delete)),
          background: Container(color: Colors.white),
          direction: DismissDirection.endToStart,
          key: Key(listItem.elementAt(index)),
          onDismissed: (direction) {
            var item = listItem.elementAt(index);
            setState(() {
              listNote.removeWhere((key, value) => key == listItem.elementAt(index));
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.indigo[200],content: Text('$item removed')));
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
                      unselectedWidgetColor: Colors.indigo
                    ),
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      value: listNote[listItem.elementAt(index)], 
                      onChanged: (value) => {
                        setState((){
                          listNote[listItem.elementAt(index)] = true;
                          completedList.add(listItem.elementAt(index));
                        }),
                        Future.delayed(const Duration(milliseconds: 500),(){
                          setState((){
                            listNote.removeWhere((key, value) => key == listItem.elementAt(index));
                          });
                        })
                      }
                    ),
                  ),
                ),
                Expanded(
                  child: Text(listItem.elementAt(index),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16)),
                )
              ]
            )
          ),
        );
      }
    );
  }

  Widget completedNotes(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: completedList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context,int index){
        return Dismissible(
          secondaryBackground: Container(color: Colors.red,padding: const EdgeInsets.only(right: 20),alignment: Alignment.centerRight,child: const Icon(Icons.delete)),
          background: Container(color: Colors.red),
          direction: DismissDirection.endToStart,
          key: Key(completedList[index]),
          onDismissed: (direction){
            var item = completedList[index];
            setState(() {
              completedList.removeWhere((element) => element == item);
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.indigo[200],content: Text('$item removed')));
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
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    value: true, 
                    onChanged: (value) => {
                      listNote[completedList[index]] = false,
                      completedList.remove(completedList[index]),
                      setState((){}),
                    }
                  ),
                ),
                Expanded(
                  child: Text(completedList[index],style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16))
                ),
              ]
            )
          ),
        );
      }
    );
  }

}