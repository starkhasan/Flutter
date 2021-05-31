import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/VirtualChatting.dart';
import 'package:hello_flutter/utils/Preferences.dart';
import 'package:lottie/lottie.dart';

class VirtualDashBoard extends StatefulWidget {
  @override
  _VirtualDashBoardState createState() => _VirtualDashBoardState();
}

class _VirtualDashBoardState extends State<VirtualDashBoard> {

  var firebaseReference;
  var lottieHeight = 0.0;
  var lottieWidth = 0.0;
  var imageHeight = 0.0;
  var imageWidth = 0.0;
  var sender = '';

  @override
  void initState() {
    Firebase.initializeApp();
    firebaseReference = FirebaseDatabase.instance.reference().child('users');
    Preferences.getSenderName().then((value) => sender = value);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lottieHeight = MediaQuery.of(context).size.height * 0.45;
    lottieWidth = MediaQuery.of(context).size.width * 0.45;
    imageHeight = MediaQuery.of(context).size.height * 0.16;
    imageWidth = MediaQuery.of(context).size.width * 0.02;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Dashboard')
      ),
      body: Container(
        child: StreamBuilder(
          stream: firebaseReference.onValue,
          builder: (context,snapshot){
            if(!snapshot.hasData || snapshot.hasError){
              return Container(child: Center(child:  CircularProgressIndicator(color: Colors.blue,strokeWidth: 3))); 
            }else if(snapshot.hasData && snapshot.data.snapshot.value != null){
              var notes = snapshot.data.snapshot.value;
              return ListView.separated(
                reverse: false,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: notes.length,
                itemBuilder: (context,index){
                  var key = notes.keys.elementAt(index);
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VirtualChatting(senderUser: sender,senderReceiver: sender+'-'+key,receiver: key[0].toUpperCase()+key.substring(1))));
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 24,
                          ),
                          SizedBox(width: imageWidth),
                          Text(
                            key[0].toUpperCase()+key.substring(1),
                            style: TextStyle(color: Colors.black,fontSize: 24)
                          )
                        ]
                      )
                    )
                  );
                }, separatorBuilder: (context,index) {
                  return Divider(color: Colors.grey,thickness: 0.5,height: 1);
                },
              );                    
            }else
              return Container(child: Center(child: Lottie.asset('assets/animationLottie/emptyScreen.json',height: lottieHeight,width: lottieWidth)));
          }
        )
      )
    );
  }
}