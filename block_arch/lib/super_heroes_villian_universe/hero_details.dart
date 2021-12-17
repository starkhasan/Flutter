import 'package:block_arch/models/super_heros_model/all_characters.dart';
import 'package:flutter/material.dart';

class HeroDetails extends StatefulWidget {
  final AllCharacters heroDetails;
  const HeroDetails({ Key? key,required this.heroDetails}) : super(key: key);

  @override
  _HeroDetailsState createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails> {
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
              title: Text(widget.heroDetails.name),
              titlePadding: const EdgeInsetsDirectional.only(start: 50,bottom: 16),
              stretchModes: const [StretchMode.zoomBackground],
              background: Image.network(widget.heroDetails.images.lg,fit: BoxFit.fill)
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
                    Text(widget.heroDetails.biography.fullName,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Birth Place',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.biography.placeOfBirth,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('First Appearance',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.biography.firstAppearance,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Alignment',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.biography.alignment,style: const TextStyle(fontSize: 12))
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
                      child: publisherLogo(widget.heroDetails.biography.publisher)
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
                    Text(widget.heroDetails.appearance.gender,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Race',style: TextStyle(fontSize: 12)),
                    widget.heroDetails.appearance.race == null
                    ? const Text('N/A',style: TextStyle(fontSize: 12))
                    : Text(widget.heroDetails.appearance.race!,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Height',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.appearance.height[0],style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Weight',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.appearance.weight[1],style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Eye Color',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.appearance.eyeColor,style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hair Color',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.appearance.hairColor,style: const TextStyle(fontSize: 12))
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
                    Text(widget.heroDetails.powerstatus.intelligence.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Strength',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.powerstatus.strength.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Speed',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.powerstatus.speed.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Durability',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.powerstatus.durability.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Power',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.powerstatus.power.toString(),style: const TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Combat',style: TextStyle(fontSize: 12)),
                    Text(widget.heroDetails.powerstatus.combat.toString(),style: const TextStyle(fontSize: 12))
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
        logo = 'assets/mcu.png';
        break;
      case 'DC Comics':
        logo = 'assets/dc.png';
        break;
      case 'Image Comics':
        logo = 'assets/image_comics.png';
        break;
      case 'Microsoft':
        logo = 'assets/Microsoft.png';
        break;
      case 'NBC - Heroes':
        logo = 'assets/heroes.png';
        break;
      case 'Icon Comics':
        logo = 'assets/image_comics.png';
        break;
      case 'Boom-Boom':
        logo = 'assets/boom.png';
        break;
      case 'IDW Publishing':
        logo = 'assets/IDW.png';
        break;
      case 'Batgirl V':
        logo = 'assets/dc.png';
        break;
      case 'Dark Horse Comics':
        logo = 'assets/dark_horse.png';
        break;
      case 'She-Thing':
        logo = 'assets/mcu.png';
        break;
      case 'Shueisha':
        logo = 'assets/Shueisha.jpg';
        break;
      case 'Batman II':
        logo = 'assets/dc.png';
        break;
      case 'SyFy':
        logo = 'assets/syfy.png';
        break;
      case 'Batgirl':
        logo = 'assets/dc.png';
        break;
      case 'Sony Pictures':
        logo = 'assets/sony.png';
        break;
      case 'Jean Grey':
        logo = 'assets/mcu.png';
        break;
      case 'Star Trek':
        logo = 'assets/star_trek.png';
        break;
      case 'Robin II':
        logo = 'assets/dc.png';
        break;
      case 'Robin III':
        logo = 'assets/dc.png';
        break;
      case 'George Lucas':
        logo = 'assets/George_Lucas.png';
        break;
      case 'Red Hood':
        logo = 'assets/dc.png';
        break;
      case 'Red Robin':
        logo = 'assets/dc.png';
        break;
      case 'Goliath':
        logo = 'assets/mcu.png';
        break;
      case 'J. R. R. Tolkien':
        logo = 'assets/new_line_cinema.png';
        break;
      case 'Spider-Carnage':
        logo = 'assets/sony.png';
        break;
      case 'Venom III':
        logo = 'assets/sony.png';
        break;
      case 'Ms Marvel II':
        logo = 'assets/mcu.png';
        break;
      case 'Aztar':
        logo = 'assets/dc.png';
        break;
      case 'ABC Studios':
        logo = 'assets/image_comics.png';
        break;
      case 'Superman Prime One-Million':
        logo = '';
        break;
      case 'Angel Salvadore':
        logo = 'assets/mcu.png';
        break;
      case 'Rune King Thor':
        logo = 'assets/mcu.png';
        break;
      case 'Anti-Venom':
        logo = 'assets/sony.png';
        break;
      case 'Scorpion':
        logo = 'assets/mcu.png';
        break;
      case 'Deadpool':
        logo = 'assets/mcu.png';
        break;
      case 'Vindicator II':
        logo = 'assets/mcu.png';
        break;
      case 'Anti-Vision':
        logo = 'Anti-Vision';
        break;
      case 'Thunderbird II':
        logo = 'assets/mcu.png';
        break;
      case 'Ant-Man':
        logo = 'assets/mcu.png';
        break;  
      default:
        logo = 'assets/sony.png';
    }
    return Image.asset(logo);
  }
}