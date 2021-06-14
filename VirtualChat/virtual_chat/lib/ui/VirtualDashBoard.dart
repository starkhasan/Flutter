import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:virtual_chat/ui/ChatMedia.dart';
import 'package:virtual_chat/ui/ChatSetting.dart';
import 'package:virtual_chat/ui/ChattingScreen.dart';
import 'package:virtual_chat/ui/LoginScreen.dart';
import 'package:virtual_chat/util/PreferenceUtil.dart';

class VirtualDashBoard extends StatefulWidget {
  @override
  _VirtualDashBoardState createState() => _VirtualDashBoardState();
}

class _VirtualDashBoardState extends State<VirtualDashBoard> {

  var databaseReference;
  var storageReference;
  var sender = '';
  var widthPad = 0.0;
  var heightPad = 0.0;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    databaseReference = FirebaseDatabase.instance.reference().child('users');
    storageReference = FirebaseStorage.instance.ref().child('messages');
    sender = PreferenceUtil.getSenderName();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widthPad = MediaQuery.of(context).size.width * 0.02;
    heightPad = MediaQuery.of(context).size.height * 0.01;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Virtual Dashboard'),
        actions: [
          popUpMenu(sender)
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: databaseReference.onValue,
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData || snapshot.hasError){
              return Container();
            }else if(snapshot.hasData && snapshot.data.snapshot.value != null){
              var allUser = snapshot.data.snapshot.value;
              return ListView.separated(
                itemCount: allUser.length,
                itemBuilder: (context,index){
                  var key = allUser.keys.elementAt(index);
                  return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingScreen(sender: sender,receiver: key))),
                    child: key!=sender
                    ? Container(
                      padding: EdgeInsets.fromLTRB(widthPad, heightPad, widthPad, heightPad),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              if(allUser[key]['profile'] != ' ') Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMedia(path: allUser[key]['profile'], name: key)));
                            },
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.blue,
                              child: allUser[key]['profile'] == ' ' ? Icon(Icons.person,size: 26,color: Colors.white) : null,
                              backgroundImage: allUser[key]['profile'] == ' ' ? null : NetworkImage(allUser[key]['profile']),
                            )
                          ),
                          SizedBox(width: 15),
                          Text(key[0].toUpperCase()+key.substring(1),style: TextStyle(color: Colors.black,fontSize: 20))
                        ]
                      )
                    )
                    : SizedBox()
                  );
                },
                separatorBuilder: (context,index){
                  return Divider(color: Colors.grey,height: 0.8);
                }
              );
            }else{
              return Container();
            }
          },
        )
      )
    );
  }

  Widget popUpMenu(String sender){
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            sender[0].toUpperCase()+sender.substring(1)
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            "Settings"
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            "Logout",
          ),
        ),
      ],
      onSelected: (pos){
        if(pos == 2){
          //Preferences.setVirtualLogin(false);
          //Preferences.setSenderName("");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
        if(pos == 1)
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatSetting(sender: sender,update: true)));
      },
    );
  }
}
