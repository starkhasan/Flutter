import 'package:flutter/material.dart';

class WhatsAppPage extends StatefulWidget {
  const WhatsAppPage({ Key? key }) : super(key: key);

  @override
  _WhatsAppPageState createState() => _WhatsAppPageState();
}

class _WhatsAppPageState extends State<WhatsAppPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              title: Text('WhatsApp'),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike))
                ]
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                  const TabBarView(
                    children: [
                      Icon(Icons.directions_car),
                      Icon(Icons.directions_transit),
                      Icon(Icons.directions_bike)
                    ]
                  )
              ])
            )
          ],
        ),
      )
    );
  }
}