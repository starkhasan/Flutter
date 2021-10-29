import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/model/input_model.dart';

class InputProvider extends ChangeNotifier {
  bool _showFab = true;
  bool _loading = false;
  bool get loadingData => _loading;
  bool get showFabButton => _showFab;
  List<InputModel> inventoryInput = [];
  var firebaseDataBaseReferene =FirebaseDatabase.instance.reference().child('inventory_control');

  void fabVisibility(bool visible) async {
    _showFab = visible;
    if(visible){
      inventoryInput.clear();
      getFirebaseInputData();
    }
    notifyListeners();
  }

  void getFirebaseInputData() async {
    _loading = true;
    notifyListeners();
    await firebaseDataBaseReferene.child('input').once().then((snapshot) => {
      if (snapshot.value != null){
        snapshot.value.keys.forEach((key) {
          var input = snapshot.value[key];
          inventoryInput.add(InputModel(
              input['createdAt'],
              input['quantity'],
              input['productID'],
              input['productDescription']
            )
          );
        })
      }else{
        inventoryInput = []
      }
    });
    _loading = false;
    notifyListeners();
  }


  bool validation(BuildContext _context,String productId,String quantity){
    if(productId.isEmpty){
      snackBar(_context,'Please provide product id');
      return false;
    }else if(quantity.isEmpty){
      snackBar(_context,'Please provide quantity');
      return false;
    }
    return true;
  } 

  Future<bool> createInventory(BuildContext _context,String productId,String quantity,String description) async{
    if(validation(_context,productId,quantity)){
      await firebaseDataBaseReferene.child('input').push().set({
        'productID': productId,
        'quantity': quantity,
        'productDescription': description,
        'createdAt': DateTime.now().toString().substring(0,19)
      });
      snackBar(_context,'Input Added');
      return true;
    }return false;
  }

  void snackBar(BuildContext _context,String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(_context).showSnackBar(snackbar);
  }
}
