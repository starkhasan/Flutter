import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_control/model/setting_inventory_model.dart';
import 'package:inventory_control/utils/helper.dart';
import 'package:inventory_control/utils/preferences.dart';

class SettingInventoryProvider extends ChangeNotifier with Helper{
  bool _isLoading = false;
  bool get loading => _isLoading;


  var firebaseReference = FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId());

  var settingInventoryData = SettingInventoryModel('2021-11-08 11:23:08.316419', false,0,0,0,0,0);

  getInventoryData(BuildContext context,String inventoryName) async{
    _isLoading = true;
    notifyListeners();
    await firebaseReference.child(inventoryName).once().then((DataSnapshot snapshot) {
      if(snapshot.value != null){
        settingInventoryData.createdAt = snapshot.value['createdAt'];
        settingInventoryData.enabled = snapshot.value['enable'];
        if(snapshot.value['input'] != null){
          settingInventoryData.inputEntry = snapshot.value['input'].length;
        }
        if(snapshot.value['output'] != null){
          settingInventoryData.outputEntry = snapshot.value['output'].length;
        }
        if(snapshot.value['inventory'] != null){
          settingInventoryData.totalProduct = snapshot.value['inventory'].length;
          var inStock = 0;
          var outStock = 0;
          for(var item in snapshot.value['inventory'].keys){
            if(snapshot.value['inventory'][item]['quantity'] > 0){
              inStock+=1;
            }else{
              outStock+=1;
            }
          }
          settingInventoryData.inStockProduct = inStock;
          settingInventoryData.outStockProduct = outStock;
        }
      }
    });
    _isLoading = false;
    notifyListeners();
  }

  enabledInventory(BuildContext context,String inventoryName,bool value) async{
    _isLoading = true;
    notifyListeners();
    await firebaseReference.child(inventoryName).update({
      'enable': value
    });
    await getInventoryData(context, inventoryName);
    _isLoading = false;
    notifyListeners();
  }

}