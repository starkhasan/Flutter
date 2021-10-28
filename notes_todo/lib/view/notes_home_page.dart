import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_todo/helper/delete_notes_dialog.dart';
import 'package:notes_todo/helper/empty_message.dart';
import 'package:notes_todo/providers/notes_provider.dart';
import 'package:notes_todo/utils/preferences.dart';
import 'package:notes_todo/view/notes_sync_page.dart';
import 'package:provider/provider.dart';
import 'package:notes_todo/utils/local_constant.dart';


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
      )
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

  bool _isDarkMode = false;
  bool _mainScreen = true;
  var textController = TextEditingController();
  List<IconData> icons = [Icons.sync,Icons.dark_mode_outlined];
  List<String> screenName = ['Sync Notes','Dark mode'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    if(Preferences.getSyncEnabled() && Preferences.getUserID().isNotEmpty) {
      Future.delayed(Duration.zero,() => widget.notesProvider.syncEnableFromSyncNote(context));
    }
    getDark().then((value) => setState((){
      _isDarkMode = value;
      Preferences.setAppTheme(value);
    }));
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance!.window.viewInsets.bottom;
    if(bottomInset == 0.0 && _mainScreen){
      widget.notesProvider.fabAction();
    }  
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        drawer: drawerLayout(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Notes',style: TextStyle(fontSize: 14)),
          actions: widget.notesProvider.completedList.isEmpty && widget.notesProvider.listNote.isEmpty && !widget.notesProvider.isDataSync
          ? null
          : [
            IconButton(
              onPressed: widget.notesProvider.isDataSync ? null : () => deleteNotesDialog(),
              icon: Icon(widget.notesProvider.isDataSync ? Icons.sync :Icons.delete,color: Colors.white,size: 22.0)
            )
          ]
        ),
        floatingActionButton: Visibility(
          visible: widget.notesProvider.fabVisible,
          child: GestureDetector(
            onTap: () => {
              _mainScreen = true,
              widget.notesProvider.fabAction(),
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.13,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                color: Preferences.getAppTheme() ? Colors.tealAccent[400] : Colors.indigo,
                shape: BoxShape.circle
              ),
              child: const Icon(Icons.add,color: Colors.white),
            ),
          )
        ),
        body: Container(
          color: _isDarkMode ? const Color(0xFF161616) : Colors.white,
          child: Stack(
            children: [ 
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(visible: widget.notesProvider.listNote.isNotEmpty,child: Container(margin: const EdgeInsets.only(left: 15,top: 10,bottom: 10),child: Text('Task',style: TextStyle(color: Preferences.getAppTheme() ? Theme.of(context).toggleableActiveColor : Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold)))),
                          notesBody(),
                          Visibility(visible: widget.notesProvider.completedList.isNotEmpty,child: Container(margin: const EdgeInsets.only(left: 15,top: 10,bottom: 10),child: Text('Completed',style: TextStyle(color: Preferences.getAppTheme() ? Theme.of(context).toggleableActiveColor : Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold)))),
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
                  child: EmptyMessage(darkMode: _isDarkMode)
                )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Visibility(
                  visible: widget.notesProvider.taskContainerVisible,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isDarkMode ? const Color(0xFF343434) : Colors.white,
                      border: const Border(top: BorderSide(color: Color(0xFFBDBDBD),width: 0.5))
                    ),
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: textController,
                      autofocus: true,
                      minLines: 1,
                      maxLines: 3,
                      cursorColor: Theme.of(context).toggleableActiveColor,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Add Task',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 12)
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
      ),
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
            padding: const EdgeInsets.only(bottom: 2,top: 2,right: 2),
            margin: const EdgeInsets.only(bottom: 5,left: 15,right: 5),
            decoration: BoxDecoration(
              color: _isDarkMode ? const Color(0xFF343434) : Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: _isDarkMode ? const Color(0xFF343434) : const Color(0xFFD6D6D6),spreadRadius: 1)]
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: 1.0,
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Preferences.getAppTheme() ? Theme.of(context).toggleableActiveColor : Colors.indigo
                    ),
                    child: Checkbox(
                      activeColor: Preferences.getAppTheme() ? Theme.of(context).toggleableActiveColor : Colors.indigo,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      value: widget.notesProvider.selectedTaskIndex == index, 
                      onChanged: (value) => widget.notesProvider.checkedTask(widget.notesProvider.listNote[index],index)
                    )
                  )
                ),
                Expanded(
                  child: Text(widget.notesProvider.listNote[index],style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black,fontWeight: FontWeight.normal,fontSize: 11)),
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
            padding: const EdgeInsets.only(bottom: 2,top: 2,right: 2),
            margin: const EdgeInsets.only(bottom: 5,left: 15,right: 5),
            decoration: BoxDecoration(
              color: _isDarkMode ? const Color(0xFF343434) : Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: _isDarkMode ? const Color(0xFF343434) : const Color(0xFFD6D6D6),spreadRadius: 1)]
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: 1.0,
                  child: Checkbox(
                    activeColor: Preferences.getAppTheme() ? Colors.tealAccent[400] : Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    value: true, 
                    onChanged: (value) => widget.notesProvider.unCheckedCompletedTask(index),
                  )
                ),
                Expanded(
                  child: Text(widget.notesProvider.completedList[index],style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey, fontWeight: FontWeight.normal,fontSize: 11))
                )
              ]
            )
          )
        );
      }
    );
  }

  Widget drawerLayout(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      color: _isDarkMode ? const Color(0xFF161616) : Colors.white,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            color: _isDarkMode ? const Color(0xFF343434) : Colors.indigo,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  right: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.14,
                    height: MediaQuery.of(context).size.height * 0.14,
                    decoration: const BoxDecoration(image: DecorationImage(opacity: 0.1,image: AssetImage('assets/logo.png'))),
                  )
                ),
                Positioned(
                  bottom: 10,
                  left: 12,
                  child: Text('Hi, ${widget.notesProvider.getUserName}',style: const TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.normal))
                )
              ]
            )
          ),
          Container(
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height * 0.80,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => pageNavigation(context),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(icons[0],size: 20,color: Preferences.getAppTheme() ? Theme.of(context).toggleableActiveColor : Colors.indigo),
                          const SizedBox(width: 5),
                          Text(screenName[0],style: const TextStyle(fontSize: 11))
                        ]
                      )
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(icons[1],size: 20,color: Preferences.getAppTheme() ? Theme.of(context).toggleableActiveColor : Colors.indigo),
                            const SizedBox(width: 5),
                            Text(screenName[1],style: const TextStyle(fontSize: 11))
                          ]
                        ),
                        Switch(
                          value: _isDarkMode,
                          onChanged: (value){
                            changeDarkMode(context, value);
                            setState(() {
                              Preferences.setAppTheme(value);
                              _isDarkMode = value;
                            });
                          }
                        )
                      ]
                    )
                  )
                ]
              )
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: Text('Traversal',style: TextStyle(color: _isDarkMode ? Colors.grey[850] : Colors.grey[100],fontSize: 12))
          )
        ]
      )
    );
  }

  pageNavigation(BuildContext _context){
    _mainScreen = false;
    Navigator.pop(_context);
    Navigator.push(_context, MaterialPageRoute(builder: (_context) => const NotesBackupPage())).then((value) => {
      if(Preferences.getSyncExplicitly()){
        Preferences.setSyncExplicitly(false),
        widget.notesProvider.syncEnableFromSyncNote(_context)
      }else{
        widget.notesProvider.drawerName()
      }
    });

    /**
     * The framework calls didChangeDependencies.
     * Subclasses of State should override didChangeDependencies to perform initialization involving inheritedWidget
     * If BuildContext.dependOnInheritedWidgetOfExactType is called, the didChangeDependencies method will be called again if the 
     * inherited widgets subsequently change or if the widget moves in the tree
     */
    //_context.dependOnInheritedWidgetOfExactType();
  }

  deleteNotesDialog(){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return DeleteNotesDialog(
          titleDialog: 'Delete all Notes',
          contentDialog: 'Are you sure you want to delete all Notes?',
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
      content: Text(message,style: const TextStyle(fontSize: 11)),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'UNDO',
        textColor: _isDarkMode ? Colors.indigo : Colors.yellow,
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

  Future<bool> onBackPressed() async {
    return await showDialog(
      context: context, 
      builder: (BuildContext context){
        return CupertinoAlertDialog(
          title: const Text('Exit'),
          content: const Text('Are you sure you want to Exit?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,false),
              child: const Text('No',style: TextStyle(color: Colors.red))
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,true),
              child: const Text('Yes')
            )
          ],
        );
      }
    ) ?? false;
  }
}
