import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InputProvider extends ChangeNotifier {
  bool _showFab = true;
  bool get showFabButton => _showFab;
  var firebaseDataBaseReferene =FirebaseDatabase.instance.reference().child('inventory_control');

  void fabVisibility(bool visible) {
    _showFab = visible;
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
