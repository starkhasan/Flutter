import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_control/model/setting_inventory_model.dart';
import 'package:inventory_control/utils/helper.dart';
import 'package:inventory_control/utils/preferences.dart';

class SettingInventoryProvider extends ChangeNotifier with Helper{
  bool _isLoading = false;
  bool get loading => _isLoading;
  List<String> allInventory = [];

  var firebaseReference = FirebaseDatabase.instance.ref().child('inventory_control').child(Preferences.getUserId());
  var settingInventoryData = SettingInventoryModel('2021-11-08 11:23:08.316419', false,0,0,0,0,0);

  getInventoryData(bool loading,BuildContext context,String inventoryName) async{
    if(loading){
      _isLoading = true;
      notifyListeners();
    }
    if(allInventory.isEmpty){
      await firebaseReference.once().then((DatabaseEvent databaseEvent){
        if(databaseEvent.snapshot.value != null){
          var data = databaseEvent.snapshot.value as Map;
          for (var item in data.keys) {
            if(item != 'email' && item != 'userName' && item != 'createdAt' && item != 'profileImage' && item != inventoryName){
              allInventory.add(item);
            }
          }
        }
      });
    }
    await firebaseReference.child(inventoryName).once().then((DatabaseEvent databaseEvent) {
      if(databaseEvent.snapshot.value != null){
        var data = databaseEvent.snapshot.value as Map;
        settingInventoryData.createdAt = data['createdAt'];
        settingInventoryData.enabled = data['enable'];
        if(data['input'] != null){
          settingInventoryData.inputEntry = data['input'].length;
        }
        if(data['output'] != null){
          settingInventoryData.outputEntry = data['output'].length;
        }
        if(data['inventory'] != null){
          settingInventoryData.totalProduct = data['inventory'].length;
          var inStock = 0;
          var outStock = 0;
          allInventory.clear();
          for(var item in data['inventory'].keys){
            allInventory.add(item);
            if(data['inventory'][item]['quantity'] > 0){
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

  renameInventoryName(BuildContext _context,String oldName,String newName) async{
    if(newName.isEmpty){
      showSnackBar(_context, 'Please provide inventory name');
    }else if(allInventory.contains(newName)){
      showSnackBar(_context, 'Name Already Exist');
    }else if(oldName == newName){
      showSnackBar(_context, 'Inventory name updated successfully');
    }else{
      _isLoading = true;
      notifyListeners();
      var oldData = <String,dynamic>{};
      await firebaseReference.child(oldName).once().then((DatabaseEvent databaseEvent) {
        if(databaseEvent.snapshot.value != null){
          oldData = databaseEvent.snapshot.value as Map<String, dynamic>;
        }
      });
      await firebaseReference.child(newName).update(oldData);
      await firebaseReference.child(oldName).remove();
      if(oldName == Preferences.getInventoryName()) Preferences.setInventoryName(newName);
      showSnackBar(_context, 'Inventory name updated successfully');
      await getInventoryData(false,_context, newName);
    }
  }

  enabledInventory(BuildContext context,String inventoryName,bool value) async{
    _isLoading = true;
    notifyListeners();
    await firebaseReference.child(inventoryName).update({
      'enable': value
    });
    await getInventoryData(false,context, inventoryName);
    _isLoading = false;
    notifyListeners();
  }

}
