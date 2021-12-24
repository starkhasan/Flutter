import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_app/ui/grocery/authentication_screen.dart';
import 'package:test_app/utils/helper.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({ Key? key }) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> with Helper{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: AppBar(backgroundColor: Colors.green), preferredSize: const Size.fromHeight(0)),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('More',style: TextStyle(color: Colors.black)),
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false
          ),
          SliverList(delegate: SliverChildListDelegate([mainBody()]))
        ]
      )
    );
  }

  Widget mainBody(){
    return ListView.builder(
      itemCount: groceryMoreItems.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context,int index){
        return GestureDetector(
          onTap: () => moreNavigationClick(context, index),
          child: Container(
            margin: const EdgeInsets.only(left: 12,right: 12,bottom: 3,top: 3),
            padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 8),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: const BorderRadius.all(Radius.circular(4))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(groceryMoreItems[index],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14))
              ]
            )
          )
        );
      }
    );
  }

  moreNavigationClick(BuildContext context,int index){
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthenticationScreen()));
        break;
      case 1:
      case 2:
      case 3:
      case 4:
        showSnackbar(context, 'Navigator not implemented yet');
        break;
      default:
    }
  }
}