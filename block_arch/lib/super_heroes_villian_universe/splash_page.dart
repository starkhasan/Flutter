import 'package:block_arch/models/super_heros_model/all_characters.dart';
import 'package:block_arch/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  List<AllCharacters> allCharacter = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { 
      callSuperHeroAPI();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => callSuperHeroAPI(),
        child: const Icon(Icons.refresh),
      ),
      body: allCharacter.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        children: List.generate(allCharacter.length, (index) => Container(height: 100,child: Image.network(allCharacter[index].images.lg),)),
      )
    );
  }

  callSuperHeroAPI() async{
    var response = await ApiProvider().superHero();
    if(response != '400'){
      allCharacter.clear();
      allCharacter = List<AllCharacters>.from(jsonDecode(response).map((x) => AllCharacters.fromJson(x)));
      print(allCharacter.length);
    }
    setState(() {});
  }
}