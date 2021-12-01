import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              snap: true,
              backgroundColor: Colors.white,
              title: const Text('Orders',style: TextStyle(color: Colors.black)),
              bottom: TabBar(
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 2.0,
                controller: tabController,
                tabs: const [
                  Padding(padding: EdgeInsets.only(bottom: 10),child: Text('Ongoing',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
                  Padding(padding: EdgeInsets.only(bottom: 10),child: Text('History',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)))
                ]
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: const [
            EmptyScreen(),
            EmptyScreen()
          ]
        )
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('There is no ongoing order right now\nyou can order from home',textAlign: TextAlign.center)
    );
  }
}
