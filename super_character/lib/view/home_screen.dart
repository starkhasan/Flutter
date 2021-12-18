import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_character/provider/character_provider.dart';
import 'package:super_character/view/character_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CharacterProvider(),
      child: Consumer<CharacterProvider>(
        builder: (context,provider,child) => MainScreen(provider: provider),
      )
    );
  }
}

class MainScreen extends StatefulWidget {
  final CharacterProvider provider;
  const MainScreen({ Key? key,required this.provider}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => widget.provider.apiAllCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            floating: true,
            snap: true,
            title: Text('Super Character',style: TextStyle(fontSize: 14)),
          ),
          widget.provider.loading
          ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
          : SliverList(delegate: SliverChildListDelegate([mainContent(widget.provider)]))
        ]
      )
    );
  }

  Widget mainContent(CharacterProvider provider){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.listCharacters.length,
      padding: const EdgeInsets.only(top: 2),
      itemBuilder: (BuildContext context,int index){
        return Container(
          padding: const EdgeInsets.all(2),
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetails(characterDetails: widget.provider.listCharacters[index]))),
            child: Card(
              elevation: 2.0,
              child: ListTile(
                title: Text(provider.listCharacters[index].name)
              ),
            ),
          )
        );
      }
    );
  }
}

