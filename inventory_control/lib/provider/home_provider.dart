
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/utils/preferences.dart';

class HomeProvider extends ChangeNotifier {
  bool _loading = true;
  bool get isLoading => _loading;
  bool _inventoryAvailable = false;
  bool get isInventoryAvailable => _inventoryAvailable;
  var firebaseReference = FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId());
  List<PopupMenuItem> listPopupMenu  = [];

  getPopupMenuData() {
    listPopupMenu.clear();
    List.generate(
      Preferences.getTotalInventory().length,
      (item) => {
        listPopupMenu.add(
          PopupMenuItem(
            value: item,
            child: Text(
              Preferences.getTotalInventory()[item],
                style: TextStyle(fontSize: 12,
                fontWeight: Preferences.getTotalInventory()[item] == Preferences.getInventoryName()
                ? FontWeight.bold
                : FontWeight.normal, 
                color: Preferences.getTotalInventory()[item] == Preferences.getInventoryName()
                  ? Colors.red
                  : Colors.black
              )
            )
          )
        ),
      }
    );
    notifyListeners();
  }

  changePopUpMenuData(Object pos) {
    var tempList = Preferences.getTotalInventory();
    for (var i = 0; i < tempList.length; i++) {
      if (i == pos) {
        Preferences.setInventoryName(tempList[i]);
        break;
      }
    }
    getPopupMenuData();
  }

  searchInventoryName(String input){
    _inventoryAvailable = false;
    if(input.isNotEmpty){
      Preferences.getTotalInventory().forEach((element) {
        if(element.startsWith(input)){
          _inventoryAvailable = true;
        }
      });
    }
    notifyListeners();
  }

  updatedInventory() async{
    await FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId()).once().then((snapshot){
      if(snapshot.value != null){
        List<String> temp = [];
        snapshot.value.keys.forEach((item) {
          if(item != 'email' && item != 'userName'){
            temp.add(item);
          }
        });
        Preferences.setTotalInventory(temp);
      }
    });
  }

  Future<bool> createInventory(String inventoryName) async{
    var returnValue = false;
    await firebaseReference.child(inventoryName).update({'createdAt': DateTime.now().toString()})
    .then((value) async{
      await updatedInventory();
      getPopupMenuData();
      returnValue = true;
    })
    .onError((error, stackTrace){returnValue = false;});
    return returnValue;
  }
}
