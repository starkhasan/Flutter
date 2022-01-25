import 'package:flutter/material.dart';
import 'package:test_app/ui/get_started/basic_widget_composition.dart';
import 'package:test_app/ui/get_started/constraint.dart';
import 'package:test_app/ui/get_started/named_route_first.dart';
import 'package:test_app/ui/get_started/networking.dart';

class GetStartedHome extends StatelessWidget {
  const GetStartedHome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = ['Basic Widgets','Network Operation','Understanding Constraint','Named Route'];
    return Scaffold(
      appBar: AppBar(title: const Text('GetStartedHome')),
      body: ListView.builder(
        itemCount: listScreen.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: () => onItemClickEvent(context, index),
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5.0)),boxShadow:[BoxShadow(color: Colors.grey,blurRadius: 2.0)]),
              child: Text(listScreen[index]) 
            )
          );
        }
      )
    );
  }

  onItemClickEvent(BuildContext _context,int index){
    switch (index) {
      case 0:
        Navigator.push(_context, MaterialPageRoute(builder: (context) => const BasicWidgetComposition()));
        break;
      case 1:
        Navigator.push(_context, MaterialPageRoute(builder: (context) => const Networking()));
        break;
      case 2:
        Navigator.push(_context, MaterialPageRoute(builder: (context) => const UnderstandingConstraint()));
        break;
      case 3:
        Navigator.push(_context, MaterialPageRoute(builder: (context) => const NamedRouteFirst()));
        break;
      default:
    }
  }
}