import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inventory_control/provider/input_provider.dart';
import 'package:inventory_control/utils/bottom_search_bar.dart';
import 'package:inventory_control/utils/inventory_container.dart';
import 'package:inventory_control/utils/preferences.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({ Key? key }) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  var firebaseDataBaseReferene = FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId()).child(Preferences.getInventoryName());

  @override
  Widget build(BuildContext context) {
    //First Provide the Provider using NotifierProviders like ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => InputProvider(),
      child: Consumer<InputProvider>(
        builder: (context,inputProvider,child){
          return MainInventoryPage(provider: inputProvider);
        }
      )
    );
  }
}

class MainInventoryPage extends StatefulWidget {
  final InputProvider provider;
  const MainInventoryPage({ Key? key,required this.provider}) : super(key: key);
  @override
  _MainInventoryPageState createState() => _MainInventoryPageState();
}

class _MainInventoryPageState extends State<MainInventoryPage> {

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(scrollListener);
  }

  scrollListener(){
    if (scrollController.offset > scrollController.position.maxScrollExtent/2) {
      if(!widget.provider.inventoryFabVisible){
        widget.provider.inventoryShowTab();
      }
    } else if(widget.provider.inventoryFabVisible){
      widget.provider.inventoryShowTab();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<InputProvider>(context,listen: false);
      provider.getTotalInventory(context,true);
    });
  }

  @override
  Widget build(BuildContext context) {
    //After user Dependent Widget of the Provider class like Consumer
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled){
          return [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              snap: true,
              pinned: false,
              title: const Text('Inventory',style: TextStyle(fontSize: 14)),
              actions: widget.provider.inventoryModel.isEmpty
              ? null
              : [IconButton(
                  onPressed: () => {
                    if(widget.provider.showSearchBar){
                      widget.provider.searchBarVisibility(false),
                      widget.provider.searchInventoryProduct('')
                    }else{
                      widget.provider.searchBarVisibility(true)
                    }
                  },
                  icon: Icon(
                    widget.provider.showSearchBar
                    ? Icons.cancel
                    : Icons.search,
                    color: Colors.white
                  )
                )
              ],
              bottom: widget.provider.showSearchBar
              ? BottomSearchBar(
                preferredHeight: kToolbarHeight,
                inputProvider: widget.provider,
              )
              : null
            )
          ];
        },
        body: widget.provider.mainInventoryLoading
        ? const Center(child: CircularProgressIndicator(strokeWidth: 3.0))
        : widget.provider.inventoryModel.isEmpty
          ? const Center(child: Text('Empty Inventory'))
          : RefreshIndicator(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.provider.inventoryModel.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context,int index){
                return InventoryContainer(provider: widget.provider, index: index);
              }
          ), 
          onRefresh: () => widget.provider.getTotalInventory(context,false)
        )
      ),
      floatingActionButton: widget.provider.inventoryFabVisible
      ? FloatingActionButton(
        onPressed: () => scrollController.animateTo(0.0, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut),
        child: const Icon(Icons.arrow_upward_outlined),
      )
      : null
    );
  }
}