import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:virtual_chat/ui/ChatMedia.dart';
import 'package:virtual_chat/ui/ChatSetting.dart';
import 'package:virtual_chat/ui/ChattingScreen.dart';
import 'package:virtual_chat/ui/LoginScreen.dart';
import 'package:virtual_chat/util/PreferenceUtil.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class VirtualDashBoard extends StatefulWidget {
  @override
  _VirtualDashBoardState createState() => _VirtualDashBoardState();
}

class _VirtualDashBoardState extends State<VirtualDashBoard> with WidgetsBindingObserver{

  var databaseReference;
  var storageReference;
  var sender = '';
  var widthPad = 0.0;
  var heightPad = 0.0;
  var lottieHeight = 0.0;
  var lottieWidth = 0.0;
  var todayDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    databaseReference = FirebaseDatabase.instance.reference().child('users');
    storageReference = FirebaseStorage.instance.ref().child('messages');
    sender = PreferenceUtil.getSenderName();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    statusOnline();
    widthPad = MediaQuery.of(context).size.width * 0.02;
    heightPad = MediaQuery.of(context).size.height * 0.01;
    lottieHeight = MediaQuery.of(context).size.height * 0.45;
    lottieWidth = MediaQuery.of(context).size.width * 0.45;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.indigo,
          title: Text('Virtual Dashboard',style: TextStyle(fontSize: 14)),
          actions: [
            popUpMenu(sender)
          ],
        ),
        body: Container(
          child: StreamBuilder(
            stream: databaseReference.onValue,
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData || snapshot.hasError){
                return Container(child: Center(child:  CircularProgressIndicator(color: Colors.indigo,strokeWidth: 3)));
              }else if(snapshot.hasData && snapshot.data.snapshot.value != null && snapshot.data.snapshot.value.length > 1){
                var allUser = snapshot.data.snapshot.value;
                return ListView.separated(
                  itemCount: allUser.length,
                  itemBuilder: (context,index){
                    var key = allUser.keys.elementAt(index);
                    return InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingScreen(sender: sender,receiver: key,senderImagePath: allUser[key]['profile']))),
                      child: key!=sender
                      ? Container(
                        padding: EdgeInsets.fromLTRB(widthPad, heightPad, widthPad, heightPad),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async{
                                    var imagePath = await getImagePath(key[0], allUser[key]['profile']);
                                    if(allUser[key]['profile'].isNotEmpty) Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMedia(path: imagePath, name: key,dateTime:'')));
                                  },
                                  child: FutureBuilder(
                                    future: getImagePath(key[0], allUser[key]['profile']),
                                    builder: (BuildContext context, AsyncSnapshot snapshot){
                                      if(snapshot.connectionState == ConnectionState.done && snapshot.data != null){
                                        return  CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.grey,
                                          backgroundImage: FileImage(File(snapshot.data))
                                        );
                                      }else{
                                        return Padding(padding: EdgeInsets.all(4),child: CircularProgressIndicator(strokeWidth: 2.0));
                                      }
                                    }
                                  )
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(key[0].toUpperCase()+key.substring(1),style: TextStyle(color: Colors.black,fontSize: 14))
                                  ]
                                )
                              ]
                            ),
                            Tooltip(
                              message:'Today is birthday of ${key[0].toUpperCase()+key.substring(1)}',
                              child: Icon(
                                allUser[key]['dob'].isEmpty
                                  ? null
                                  : allUser[key]['dob'].substring(5,10) == todayDate.toString().substring(5,10)
                                    ? Icons.cake_rounded
                                    : null,
                                color: Colors.red
                              )
                            )
                          ]
                        )
                      )
                      : SizedBox()
                    );
                  },
                  separatorBuilder: (context,index){
                    return Divider(color: Colors.grey[400],height: 0.5);
                  }
                );
              }else{
                return Container(child: Center(child: Lottie.asset('assets/animationLottie/emptyScreen.json',height: lottieHeight,width: lottieWidth)));
              }
            }
          )
        )
      )
    );
  }

  Widget popUpMenu(String sender){
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      iconSize: 22,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            sender[0].toUpperCase()+sender.substring(1),
            style: TextStyle(fontSize: 12,color: Colors.black)
          )
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 12,color: Colors.black)
          )
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            "Logout",
            style: TextStyle(fontSize: 12,color: Colors.red)
          )
        )
      ],
      onSelected: (pos){
        if(pos == 2){
          statusOffline();
          PreferenceUtil.setSenderName("");
          PreferenceUtil.setLogin(false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
        if(pos == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatSetting(sender: sender,update: true)));
        }
      }
    );
  }

  Future<String> getImagePath(String name,String url) async{
    url = url.isEmpty ? 'https://i.ibb.co/Tm8jmFY/add-1.png' : url;
    //var imageName = notes[key]['time'].substring(0,10).replaceAll('-','')
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/IMG-${name.replaceAll(RegExp(r"[\\-\s+\\,:.]"),'')}.jpg');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  Future<bool> onBackPress() async{
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('Exit'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,false),
              child: Text('No',style: TextStyle(color: Colors.red)), 
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,true),
              child: Text('Yes')
            )
          ]
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      statusOnline();
    }else{
      statusOffline();
    }
  }

  statusOnline(){
    databaseReference.child(sender).update({
        'status': 'online'
    });
  }

  statusOffline(){
    databaseReference.child(sender).update({
        'status': 'offline'
    });
  }
}
