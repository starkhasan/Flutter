import 'package:block_arch/models/super_heros_model/all_characters.dart';
import 'package:block_arch/network/api_provider.dart';
import 'package:block_arch/super_heroes_villian_universe/hero_details.dart';
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
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.blue)),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Super Heros',style: TextStyle(fontSize: 14)),
            centerTitle: true,
            floating: true,
            snap: true
          ),
          allCharacter.isEmpty
          ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
          : SliverList(delegate: SliverChildListDelegate([mainBody()]))
        ]
      )
    );
  }

  Widget mainBody(){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 3 : 3),
      itemCount: allCharacter.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 2),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context,index) {
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HeroDetails(heroDetails: allCharacter[index]))),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color:Colors.grey[100],
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              image: DecorationImage(
                image: NetworkImage(allCharacter[index].images.lg),
                fit: BoxFit.fill
              )
            )
          )
        );
      }
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