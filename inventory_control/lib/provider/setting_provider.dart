import 'package:flutter/cupertino.dart';
import 'package:inventory_control/utils/helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inventory_control/model/setting_model.dart';
import 'package:inventory_control/utils/preferences.dart';

class SettingProvider extends ChangeNotifier with Helper {
  bool _isLoading = false;
  bool get loading => _isLoading;
  var inventoryData = SettingModel(' ', ' ', '2021-11-08 11:23:08.316419', []);

  var firebaseReference = FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId());

  getInventoryData() async {
    _isLoading = true;
    notifyListeners();
    await firebaseReference.once().then((snapshot) {
      if(snapshot.value != null){
        inventoryData.createdAt = snapshot.value['createdAt'];
        inventoryData.email = snapshot.value['email'];
        inventoryData.userName = snapshot.value['userName'];
        List<String> tempInventory = [];
        for(var item in snapshot.value.keys){
          if(item != 'createdAt' && item != 'email' && item != 'userName'){
            tempInventory.add(item);
          }
        }
        inventoryData.listInventory = tempInventory;
      }
    });
    _isLoading = false;
    notifyListeners();
  }

  changeName(BuildContext _context,String name) async {
    if(name.isNotEmpty){
      await firebaseReference.update({'userName': name});
      await getInventoryData();
      showSnackBar(_context, 'Profile updated Successfully');
    }else{
      showSnackBar(_context, 'Please provide name');
    }
  }
}
