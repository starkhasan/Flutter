import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/constants/app_constant.dart';
import 'package:inventory_control/view/authentication_page.dart';
import 'package:inventory_control/view/input_page.dart';
import 'package:inventory_control/view/inventory_page.dart';
import 'package:inventory_control/view/output_page.dart';
import 'package:inventory_control/utils/preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Preferences.getInventoryName(),style: const TextStyle(fontSize: 14)),
          actions: [
            IconButton(
              onPressed: () async{
                if(await showLogoutDialog()){
                  Preferences.setLogin(false);
                  Preferences.setInventoryName('');
                  Preferences.setUserId('');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationPage()));
                }
              }, 
              icon: const Icon(Icons.logout)
            )
          ],
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
      ),
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

  Future<bool> showLogoutDialog() async{
    return await showDialog(
      context: context, 
      builder: (context){
        return CupertinoAlertDialog(
          title: const Text('Logout',style: TextStyle(fontSize: 14)),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,false),
              child: const Text('No',style: TextStyle(fontSize: 14,color: Colors.red)),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,true),
              child: const Text('Yes',style: TextStyle(fontSize: 14)),
            )
          ],
        );
      }
    ) ?? false;
  }

  Future<bool> showExitDialog() async{
    return await showDialog(
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: const Text('Exit',style: TextStyle(fontSize: 14)),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,false),
              child: const Text('No',style: TextStyle(fontSize: 14,color: Colors.red)),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,true),
              child: const Text('Yes',style: TextStyle(fontSize: 14)),
            )
          ],
        );
      }
    ) ?? false;
  }
}