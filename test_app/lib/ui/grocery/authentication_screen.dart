import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({ Key? key }) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),child: const Center(child: Text('Grocery Plus',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)))),
             DefaultTabController(
              length: 2, 
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: AppBar(
                    bottom: const TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.home)),
                        Tab(icon: Icon(Icons.contacts)),
                      ]
                    )
                  )
                ),
                body: TabBarView(
                  children: List.generate(2, (index) => Container(height: MediaQuery.of(context).size.height * 0.50,child: Text('Tab ${index+1}')))
                ),
              )
            )
          ]
        )
      )
    );
  }
}