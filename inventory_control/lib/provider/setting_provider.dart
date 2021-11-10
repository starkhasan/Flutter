import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_control/utils/helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inventory_control/model/setting_model.dart';
import 'package:inventory_control/utils/preferences.dart';

class SettingProvider extends ChangeNotifier with Helper {
  bool _isLoading = false;
  bool get loading => _isLoading;
  var inventoryData = SettingModel('', '', '2021-11-08 11:23:08.316419', [],'');

  var firebaseReference = FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId());

  getInventoryData() async {
    if(!_isLoading){
      _isLoading = true;
      notifyListeners();
    }
    await firebaseReference.once().then((snapshot) {
      if(snapshot.value != null){
        inventoryData.createdAt = snapshot.value['createdAt'];
        inventoryData.email = snapshot.value['email'];
        inventoryData.userName = snapshot.value['userName'];
        inventoryData.imagePath = snapshot.value['profileImage'];
        List<String> tempInventory = [];
        for(var item in snapshot.value.keys){
          if(item != 'createdAt' && item != 'email' && item != 'userName' && item != 'profileImage'){
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


  Future<void> uploadImageFile(BuildContext _context,ImageSource imgSource) async{
    var photo = await ImagePicker().pickImage(source: imgSource);
    if(photo!=null){
      var file = File(photo.path);
      var firebaseStorage = FirebaseStorage.instance.ref().child("inventory_control/${Preferences.getUserId()}"); 
      UploadTask uploadTask = firebaseStorage.putFile(file);
      if(uploadTask != null){
        var snapshot = await uploadTask.whenComplete(() => {
          print('Successfully uploaded')
        });
        _isLoading = true;
        notifyListeners();
        var _imageURL = await snapshot.ref.getDownloadURL();
        firebaseReference.update({
          'profileImage': _imageURL
        }).then((value){
          showSnackBar(_context,'Profile Uploaded Successfully');
        }).catchError((value){
          showSnackBar(_context,'Something went wrong');
        });
        await getInventoryData();
      }else{
        print('Upload Task is null : ');
      }
    }
    if(_isLoading){
      _isLoading = false;
      notifyListeners();
    }
  }

}
