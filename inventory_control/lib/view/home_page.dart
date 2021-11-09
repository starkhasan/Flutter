import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/constants/app_constant.dart';
import 'package:inventory_control/provider/home_provider.dart';
import 'package:inventory_control/utils/confirmation_dialog.dart';
import 'package:inventory_control/utils/helper.dart';
import 'package:inventory_control/utils/inventory_create_dialog.dart';
import 'package:inventory_control/view/authentication_page.dart';
import 'package:inventory_control/utils/preferences.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context,provider,child){
          return MainHomePage(homeProvider: provider);
        }
      ),
    );
  }
}

class MainHomePage extends StatefulWidget {
  final HomeProvider homeProvider;
  const MainHomePage({ Key? key,required this.homeProvider}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> with Helper{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { 
      widget.homeProvider.getPopupMenuData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(),
      child: Scaffold(
        drawer: drawerLayout(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Preferences.getTotalInventory().isNotEmpty
            ? Preferences.getInventoryName()
            : 'Inventory Control',
            style: const TextStyle(fontSize: 14)
          ),
          actions: [popUpMenu()],
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 5),
          child: Preferences.getTotalInventory().isNotEmpty
          ? ListView.builder(
            itemCount: AppConstant.homeTitle.length,
            itemBuilder: (BuildContext context,int index){
              return InkWell(
                onTap: () => homePageNavigation(context, index),
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
                )
              );
            }
          )
          : const Center(child: Text('Please create inventory'),)
        )
      )
    );
  }

  Widget popUpMenu(){
    return PopupMenuButton(
      onSelected: (value) => widget.homeProvider.changePopUpMenuData(value!),
      padding: EdgeInsets.zero,
      iconSize: 22,
      itemBuilder: (context) => widget.homeProvider.listPopupMenu,
    );
  }

  showLogoutDialog() {
    showDialog(
      context: context, 
      builder: (context){
        return ConfirmationDialog(
          title: 'Logout', 
          content: 'Are you sure you want to logout?', 
          onPressed: () => {
            Preferences.setLogin(false),
            Preferences.setInventoryName(''),
            Preferences.setUserId(''),
            Preferences.setUserName(''),
            Preferences.setTotalInventory([]),
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AuthenticationPage()), (route) => false)
          }
        );
      }
    );
  }


  Widget drawerLayout(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      color: Colors.white,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            color: Colors.blue,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5,left: 10,bottom: 5),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 26.0,
                  backgroundImage: AssetImage('asset/app_icon.png'),
                  backgroundColor: Colors.blue
                ),
                const SizedBox(height: 20),
                Text('Hi, ${Preferences.getUserName()}',style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold))
              ]
            )
          ),
          Container(
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height * 0.79,
            child: ListView.builder(
              itemCount: AppConstant.homeIcon.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index){
                return InkWell(
                  onTap: () => drawerClick(context, index, widget.homeProvider),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        AppConstant.homeIcon[index],
                        const SizedBox(width: 10),
                        Text(AppConstant.screenName[index],style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
                      ]
                    )
                  )
                );
              }
            )
          ),
          InkWell(
            onTap: () => showLogoutDialog(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              padding: const EdgeInsets.only(left: 10,right: 10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 1.0,color: Color(0xFFD6D6D6)))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Logout',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 14)),
                  Icon(Icons.logout,color: Colors.red)
                ]
              )
            )
          )
        ]
      )
    );
  }

  showInventoryDialog() {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context){
        return CreateInventoryDialog(provider: widget.homeProvider);
      }
    );
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
              child: const Text('No',style: TextStyle(fontSize: 14,color: Colors.red))
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,true),
              child: const Text('Yes',style: TextStyle(fontSize: 14))
            )
          ]
        );
      }
    ) ?? false;
  }
}