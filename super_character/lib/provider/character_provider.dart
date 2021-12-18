import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:super_character/model/all_characters.dart';
import 'package:super_character/model/api_provider.dart';

class CharacterProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;
  List<AllCharacters> listCharacters = [];

  void apiAllCharacters() async {
    _isLoading = true;
    notifyListeners();
    var response = await ApiProvider.superHero();
    if(response != '400'){
      listCharacters = List<AllCharacters>.from(jsonDecode(response).map((x) => AllCharacters.fromJson(x)));
    }else{
      listCharacters = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
