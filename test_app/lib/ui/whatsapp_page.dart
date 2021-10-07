import 'package:flutter/material.dart';

class WhatsAppPage extends StatefulWidget {
  const WhatsAppPage({ Key? key }) : super(key: key);

  @override
  _WhatsAppPageState createState() => _WhatsAppPageState();
}

class _WhatsAppPageState extends State<WhatsAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () => print('Search'),
                icon: const Icon(Icons.search)
              ),
              IconButton(
                onPressed: () => print('More'),
                icon: const Icon(Icons.more_vert)
              )
            ],
            centerTitle: false,
            title: const Text('WhatsApp')
          ),
          SliverList(
            delegate: SliverChildListDelegate([mainBody()])
          )
        ]
      )
    );
  }

  Widget mainBody(){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ]
          )
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        )
      )
    );
  }
}