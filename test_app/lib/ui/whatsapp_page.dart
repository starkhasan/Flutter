import 'package:flutter/material.dart';

class WhatsAppPage extends StatefulWidget {
  const WhatsAppPage({Key? key}) : super(key: key);

  @override
  _WhatsAppPageState createState() => _WhatsAppPageState();
}

class _WhatsAppPageState extends State<WhatsAppPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  var fabIcon = Icons.chat;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this
    );
    _tabController.addListener(tabListener);
    super.initState();
  }


  tabListener(){
    if(_tabController.index == 2) {
      setState((){fabIcon = Icons.add_call;});
    } else {
      setState(() {fabIcon = Icons.chat;});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSnackBar(context,'Click to Send Direct Message'),
        child: Icon(fabIcon,color: Colors.white,size: 28),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              snap: true,
              centerTitle: false,
              backgroundColor: const Color(0xFF323232),
              actions: [
                IconButton(
                  onPressed: () => showSnackBar(context,'Click on Search'),
                  icon: const Icon(Icons.search,color: Colors.grey)
                ),
                IconButton(
                  onPressed: () => showSnackBar(context,'Click on More'),
                  icon: const Icon(Icons.more_vert,color: Colors.grey)
                )
              ],
              title: const Text('WhatsApp',style: TextStyle(color: Colors.grey)),
              bottom: TabBar(
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.teal[700],
                labelColor: Colors.teal[700],
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 4.0,
                controller: _tabController,
                tabs: const [
                  Tab(text: 'CHATS'),
                  Tab(text: 'STATUS'),
                  Tab(text: 'CALLS')
                ]
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            ListA(),
            ListA(),
            ListA()
          ]
        )
      ),
    );
  }

  showSnackBar(BuildContext _context,String message){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
}

class ListA extends StatelessWidget {
  const ListA({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 20,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index){
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10,top: 15,right: 10,bottom: 15),
          color: const Color(0xFF212121),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.tealAccent[700],
                    backgroundImage: const NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ')
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Ali Hasan',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                      Text('Thank you',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12))
                    ]
                  )
                ]
              ),
              const Text('19:44',style: TextStyle(color: Colors.grey,fontSize: 11,fontWeight: FontWeight.normal))
            ]
          )
        );
      }
    );
  }
}


