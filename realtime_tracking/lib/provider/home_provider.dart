import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realtime_tracking/util/helper.dart';
import 'package:realtime_tracking/view/realtime_tracking_screen.dart';

class HomeProvider extends ChangeNotifier with  Helper{

  var collectionUser = FirebaseFirestore.instance.collection('users');

  Future<void> connectDevice(BuildContext _context,String otherId,String selfId) async{
    if(selfId.isEmpty){
      showSnackBar(_context, 'Please Provide your Id');
    }else if(otherId.isEmpty){
      showSnackBar(_context, 'Please provide user id');
    }else{
      collectionUser.doc(selfId).update({'online': false,'response': true});
      collectionUser.doc(otherId).update({'requestId':selfId,'request': true});
    }
  }

  updateDatabase(BuildContext _context,String userId,String senderId){
    collectionUser.doc(userId).update({'response': false});
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => Navigator.push(_context, MaterialPageRoute(builder: (context) => RealTimeTracking(currentUserId: '979234',senderId: senderId)))
    );
  }

  requestAccept(BuildContext _context,String id,String senderId) async{
    collectionUser.doc(id).update({'request': false,'shareLocation': true});
    collectionUser.doc(senderId).update({'shareLocation': true});
  }

}