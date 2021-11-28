import 'package:flutter/cupertino.dart';
import 'package:realtime_tracking/util/helper.dart';

class HomeProvider extends ChangeNotifier with  Helper{

  Future<void> connectDevice(BuildContext _context,String otherId,String selfId) async{
    if(selfId.isEmpty){
      showSnackBar(_context, 'Please Provide your Id');
    }else if(otherId.isEmpty){
      showSnackBar(_context, 'Please provide user id');
    }else{

    }
  }
}