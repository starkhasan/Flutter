import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({ Key? key }) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  Map<String,bool> listNote = {
    'Marketing' : false,
    'Submit Tution Fee': false,
    'Submit Electricity Bill': false,
    'Submit Internet Bill':false,
    'Submit Gas Bill': false,
    'Order a new Mouse': false,
    'Design New UI of Deliver Application': false
  };
  
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () => FocusScope.of(context).requestFocus(),
        child: const Icon(Icons.add,color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color:Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(visible: listNote.isNotEmpty,child: Container(margin: const EdgeInsets.only(top:20,bottom: 20),child: const Text('Task',style: TextStyle(color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold)))),
                    notesBody(),
                    Visibility(visible: completedList.isNotEmpty,child: Container(margin: const EdgeInsets.only(top:20,bottom: 20),child: const Text('Completed',style: TextStyle(color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold)))),
                    completedNotes()
                  ],
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
      shrinkWrap: true,
      itemCount: listNote.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context,int index){
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10,left: 5,right: 5),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 2)]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(listItem.elementAt(index),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),
              ),
              Transform.scale(
                scale: 1.5,
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
              )
            ]
          )
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
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10,left: 5,right: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 2)]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(completedList[index],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18))
              ),
              Transform.scale(
                scale: 1.5,
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
              )
            ]
          )
        );
      }
    );
  }

}