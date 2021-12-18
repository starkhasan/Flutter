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
              title: Text(widget.characterDetails.name,style: const TextStyle(color: Colors.black)),
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
      case 'Angel Salvadore':
      case 'Rune King Thor':
      case 'Scorpion':
      case 'Deadpool':
      case 'Vindicator II':
      case 'Anti-Vision':
      case 'Thunderbird II':
      case 'Ant-Man':
      case 'Giant-Man':
      case 'Ms Marvel II':
      case 'Goliath':
      case 'Jean Grey':
      case 'She-Thing':
      case 'Binary':
      case 'Marvel Comics':
        logo = 'asset/mcu.png';
        break;
      case 'Aztar':
      case 'Red Hood':
      case 'Red Robin':
      case 'Robin III':
      case 'Robin II':
      case 'Batgirl':
      case 'Nightwing':
      case 'Spoiler':
      case 'Batman II':
      case 'Oracle':
      case 'DC Comics':
      case 'Batgirl V':
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
      case 'Dark Horse Comics':
        logo = 'asset/dark_horse.png';
        break;
      case 'Shueisha':
        logo = 'asset/Shueisha.jpg';
        break;
      case 'SyFy':
        logo = 'asset/syfy.png';
        break;
      case 'Sony Pictures':
        logo = 'asset/sony.png';
        break;
      case 'Star Trek':
        logo = 'asset/star_trek.png';
        break;
      case 'George Lucas':
        logo = 'asset/George_Lucas.png';
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
      case 'ABC Studios':
        logo = 'asset/image_comics.png';
        break;
      case 'Anti-Venom':
        logo = 'asset/sony.png';
        break; 
      default:
        logo = 'asset/sony.png';
    }
    return Image.asset(logo);
  }

}