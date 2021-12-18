import 'package:flutter/material.dart';
import 'package:super_character/model/all_characters.dart';

class CharacterDetails extends StatefulWidget {
  final AllCharacters characterDetails;
  const CharacterDetails({ Key? key,required this.characterDetails}) : super(key: key);

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            stretch: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.50,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.characterDetails.name),
              titlePadding: const EdgeInsetsDirectional.only(start: 50,bottom: 16),
              stretchModes: const [StretchMode.zoomBackground],
              background: Image.network(widget.characterDetails.images.lg,fit: BoxFit.fill)
            )
          ),
          SliverList(delegate: SliverChildListDelegate([mainBody()]))
        ]
      )
    );
  }

  Widget mainBody(){
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(color: Colors.grey[200],width: double.infinity,padding: const EdgeInsets.all(10),child: const Text('Biography',style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('FullName',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.biography.fullName,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Birth Place',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.biography.placeOfBirth,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('First Appearance',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.biography.firstAppearance,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Alignment',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.biography.alignment,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Publisher',style: TextStyle(fontSize: 12)),
                    SizedBox(
                      width: 40,
                      height: 20,
                      child: publisherLogo(widget.characterDetails.biography.publisher)
                    )
                  ]
                )
              ]
            )
          ),
          const Divider(thickness: 1,height: 1),
          Container(color: Colors.grey[200],width: double.infinity,padding: const EdgeInsets.all(10),child: const Text('Appearance',style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Gender',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.appearance.gender,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Race',style: TextStyle(fontSize: 12)),
                    widget.characterDetails.appearance.race == null
                    ? const Text('N/A',style: TextStyle(fontSize: 12))
                    : Text(widget.characterDetails.appearance.race!,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Height',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.appearance.height[0],style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Weight',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.appearance.weight[1],style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Eye Color',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.appearance.eyeColor,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hair Color',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.appearance.hairColor,style: const TextStyle(fontSize: 12))
                  ]
                )
              ]
            )
          ),
          const Divider(thickness: 1,height: 1),
          Container(color: Colors.grey[200],width: double.infinity,padding: const EdgeInsets.all(10),child: const Text('Powerstats',style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Intelligence',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.powerstatus.intelligence.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Strength',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.powerstatus.strength.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Speed',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.powerstatus.speed.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Durability',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.powerstatus.durability.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Power',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.powerstatus.power.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Combat',style: TextStyle(fontSize: 12)),
                    Text(widget.characterDetails.powerstatus.combat.toString(),style: const TextStyle(fontSize: 12))
                  ]
                )
              ]
            )
          )
        ]
      )
    );
  }


  Widget publisherLogo(String? publisher){
    var logo = '';
    switch (publisher) {
      case 'Marvel Comics':
        logo = 'asset/mcu.png';
        break;
      case 'DC Comics':
        logo = 'asset/dc.png';
        break;
      case 'Image Comics':
        logo = 'asset/image_comics.png';
        break;
      case 'Microsoft':
        logo = 'asset/Microsoft.png';
        break;
      case 'NBC - Heroes':
        logo = 'asset/heroes.png';
        break;
      case 'Icon Comics':
        logo = 'asset/image_comics.png';
        break;
      case 'Boom-Boom':
        logo = 'asset/boom.png';
        break;
      case 'IDW Publishing':
        logo = 'asset/IDW.png';
        break;
      case 'Batgirl V':
        logo = 'asset/dc.png';
        break;
      case 'Dark Horse Comics':
        logo = 'asset/dark_horse.png';
        break;
      case 'She-Thing':
        logo = 'asset/mcu.png';
        break;
      case 'Shueisha':
        logo = 'asset/Shueisha.jpg';
        break;
      case 'Batman II':
        logo = 'asset/dc.png';
        break;
      case 'SyFy':
        logo = 'asset/syfy.png';
        break;
      case 'Batgirl':
        logo = 'asset/dc.png';
        break;
      case 'Sony Pictures':
        logo = 'asset/sony.png';
        break;
      case 'Jean Grey':
        logo = 'asset/mcu.png';
        break;
      case 'Star Trek':
        logo = 'asset/star_trek.png';
        break;
      case 'Robin II':
        logo = 'asset/dc.png';
        break;
      case 'Robin III':
        logo = 'asset/dc.png';
        break;
      case 'George Lucas':
        logo = 'asset/George_Lucas.png';
        break;
      case 'Red Hood':
        logo = 'asset/dc.png';
        break;
      case 'Red Robin':
        logo = 'asset/dc.png';
        break;
      case 'Goliath':
        logo = 'asset/mcu.png';
        break;
      case 'J. R. R. Tolkien':
        logo = 'asset/new_line_cinema.png';
        break;
      case 'Spider-Carnage':
        logo = 'asset/sony.png';
        break;
      case 'Venom III':
        logo = 'asset/sony.png';
        break;
      case 'Ms Marvel II':
        logo = 'asset/mcu.png';
        break;
      case 'Aztar':
        logo = 'asset/dc.png';
        break;
      case 'ABC Studios':
        logo = 'asset/image_comics.png';
        break;
      case 'Superman Prime One-Million':
        logo = '';
        break;
      case 'Angel Salvadore':
        logo = 'asset/mcu.png';
        break;
      case 'Rune King Thor':
        logo = 'asset/mcu.png';
        break;
      case 'Anti-Venom':
        logo = 'asset/sony.png';
        break;
      case 'Scorpion':
        logo = 'asset/mcu.png';
        break;
      case 'Deadpool':
        logo = 'asset/mcu.png';
        break;
      case 'Vindicator II':
        logo = 'asset/mcu.png';
        break;
      case 'Anti-Vision':
        logo = 'Anti-Vision';
        break;
      case 'Thunderbird II':
        logo = 'asset/mcu.png';
        break;
      case 'Ant-Man':
        logo = 'asset/mcu.png';
        break;
      case 'Giant-Man':
        logo = 'asset/mcu.png';
        break;  
      default:
        logo = 'asset/sony.png';
    }
    return Image.asset(logo);
  }

}