import 'package:flutter/material.dart';
import 'package:inventory_control/constants/app_constant.dart';
import 'package:inventory_control/view/input_page.dart';
import 'package:inventory_control/view/inventory_page.dart';
import 'package:inventory_control/view/output_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home',style: TextStyle(fontSize: 14))
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 5),
        child: ListView.builder(
          itemCount: AppConstant.homeTitle.length,
          itemBuilder: (BuildContext context,int index){
            return InkWell(
              onTap: () => pageNavigation(index),
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 4,left: 10,right: 10,bottom: 4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 1.0)]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppConstant.homeTitle[index],style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                    AppConstant.icons[index]
                  ]
                )              
              ),
            );
          }
        )
      )
    );
  }


  void pageNavigation(int index){
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const InputPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const OutputPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const InventoryPage()));
        break;
      default:
    }
  }
}