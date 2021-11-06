import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/model/inventory_model.dart';
import 'package:inventory_control/services/connectivity_service.dart';
import 'package:inventory_control/utils/preferences.dart';

class InputProvider extends ChangeNotifier {
  bool _inventoryFab = false;
  bool _searchBar = false;
  bool _showFab = true;
  bool _showInStock = false;
  int _quantity = 0;
  bool _inventoryLoading = true;
  bool get inventoryFabVisible => _inventoryFab;
  bool get showSearchBar => _searchBar;
  bool get mainInventoryLoading => _inventoryLoading;
  bool get showStock => _showInStock;
  int get productQuantity => _quantity;
  bool get showFabButton => _showFab;
  Map<String,dynamic> inventoryData = {};
  List<InventoryModel> inventoryModel = [];
  List<InventoryModel> inventoryModelOriginal = [];
  List<String> productId = [];
  var firebaseDataBaseReferene = FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId());

  void fabVisibility(bool visible) {
    if(visible){
      _showInStock = false;
    }
    _showFab = visible;
    notifyListeners();
  }

  inventoryShowTab(){
    _inventoryFab = _inventoryFab ? false : true;
    notifyListeners();
  }

  void searchBarVisibility(bool isVisible){
    _searchBar = isVisible;
    notifyListeners();
  }

  void getInventoryData(String product) async{
    await firebaseDataBaseReferene.child('inventory').once().then((snapshot){
      if(snapshot.value != null){
        inventoryData.clear();
        productId.clear();
        var invData = snapshot.value;
        for(var item in invData.keys){
          productId.add(item);
          inventoryData[item] = invData[item]['quantity'];
          if(product.isNotEmpty){
            _quantity = invData[product]['quantity'];
          }
        }
      }else{
        inventoryData = {};
      }
    });
    notifyListeners();
  }

  void onSelectAutoCompleteText(String value){
    _showInStock = true;
    _quantity = inventoryData[value];
    notifyListeners();
  }

  bool validation(BuildContext _context,String productId,String quantity){
    if(productId.isEmpty){
      snackBar(_context,'Please provide product id');
      return false;
    }else if(quantity.isEmpty){
      snackBar(_context,'Please provide quantity');
      return false;
    }else if(int.parse(quantity) <= 0){
      snackBar(_context,'Please provide valid quantity');
      return false;
    }
    return true;
  } 

  Future<bool> createInventory(BuildContext _context,String productId,String quantity,String description) async{
    if(await ConnectivityService().getConnection()){
      if(validation(_context,productId,quantity)){
        var time = DateTime.now().toString().substring(0,19);
        await firebaseDataBaseReferene.child('input').push().set({
          'productID': productId,
          'quantity': quantity,
          'productDescription': description,
          'createdAt': time
        });
        await firebaseDataBaseReferene.child('inventory').child(productId).update({
          'updatedAt': time,
          'quantity': ServerValue.increment(int.parse(quantity)),
          'productDescription': description
        });
        snackBar(_context,'Input Added');
        return true;
      }
      return false;
    }else{
      snackBar(_context,'No Internet Connection');
      return false;
    }
  }

  Future<bool> removeInventory(BuildContext _context,String productId,String quantity,String description) async{
    if(await ConnectivityService().getConnection()){
      if(outputValidation(_context,productId,quantity)){
        var time = DateTime.now().toString().substring(0,19);
        await firebaseDataBaseReferene.child('output').push().set({
          'productID': productId,
          'quantity': quantity,
          'productDescription': description,
          'createdAt': time
        });
        await firebaseDataBaseReferene.child('inventory').child(productId).update({
          'updatedAt': time,
          'quantity': ServerValue.increment(-int.parse(quantity)),
        });
        getInventoryData(productId);
        snackBar(_context,'Input Added');
        return true;
      }
      return false;
    }else{
      snackBar(_context,'No Internet Connection');
      return false;
    }
  }

  Future<void> getTotalInventory(BuildContext _context,bool showIndicator) async{
    _inventoryLoading = showIndicator;
    notifyListeners();
    await firebaseDataBaseReferene.child('inventory').once().then((snapshot) {
      if(snapshot.value != null){
        var input = snapshot.value;
        inventoryModel.clear();
        inventoryModelOriginal.clear();
        List<InventoryModel> temp = [];
        for(var itemKey in input.keys){
          temp.add(
            InventoryModel(
              itemKey, 
              input[itemKey]['quantity'], 
              input[itemKey]['productDescription'], 
              input[itemKey]['updatedAt']
            )
          );
        }
        inventoryModel.addAll(temp);
        inventoryModelOriginal.addAll(temp);
      }else{
        inventoryModel = [];
      }
    });
    _inventoryLoading = false;
    notifyListeners();
  }

  void searchInventoryProduct(String productId){

    if(productId.isNotEmpty){
      for(var item in inventoryModelOriginal){
        if(item.productId.toLowerCase().contains(productId.toLowerCase())){
          inventoryModel.add(item);
        }
      }
    }else{
      inventoryModel.addAll(inventoryModelOriginal);
    }
    notifyListeners();
  }

  bool outputValidation(BuildContext _context,String productId,String quantity){
    if(productId.isEmpty){
      snackBar(_context,'Please provide product id');
      return false;
    }else if(!inventoryData.containsKey(productId)){
      snackBar(_context,'Product not found, Please add first');
      return false;
    }else if(quantity.isEmpty){
      snackBar(_context,'Please provide quantity');
      return false;
    }else if(int.parse(quantity) <= 0){
      snackBar(_context,'Please provide valid quantity');
      return false;
    }else if(inventoryData[productId] < int.parse(quantity)){
      if(inventoryData[productId] == 0){
        snackBar(_context,'Out of Stock');
      }else{
        snackBar(_context,'Maximum ${inventoryData[productId]} stock available of $productId');
      }
      return false;
    }
    return true;
  }

  void snackBar(BuildContext _context,String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(_context).showSnackBar(snackbar);
  }
}
