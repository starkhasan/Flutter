import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/constants/app_constant.dart';
import 'package:inventory_control/provider/home_provider.dart';
import 'package:inventory_control/utils/confirmation_dialog.dart';
import 'package:inventory_control/view/authentication_page.dart';
import 'package:inventory_control/view/input_page.dart';
import 'package:inventory_control/view/inventory_page.dart';
import 'package:inventory_control/view/output_page.dart';
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

class _MainHomePageState extends State<MainHomePage> {

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
                  onTap: () => drawerClick(index),
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

  void drawerClick(int index){
    switch (index) {
      case 0:
        Navigator.pop(context);
        showInventoryDialog();
        break;
      case 1:
        print('Print Here to Open Setting Screen');
        break;
      default:
    }
  }


  showInventoryDialog() {
    showDialog(
      context: context, 
      builder: (context){
        return CreatedDialog(provider: widget.homeProvider);
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

class CreatedDialog extends StatefulWidget {
  final HomeProvider provider;
  const CreatedDialog({ Key? key,required this.provider}) : super(key: key);

  @override
  _CreatedDialogState createState() => _CreatedDialogState();
}

class _CreatedDialogState extends State<CreatedDialog> {

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Create New Inventory',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: textController.text.isNotEmpty,
                    child: Text(
                      widget.provider.isInventoryAvailable
                      ? 'Not Available'
                      : 'Available',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: widget.provider.isInventoryAvailable ? Colors.red : Colors.green,fontSize: 12)
                    ),
                  )
                )
              ]
            ),
            const SizedBox(height: 15),
            TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Inventory Name',
                labelText: 'Inventory Name',
                hintStyle: TextStyle(color: Colors.grey)
              ),
              onChanged: (value) => {
                if(value.isNotEmpty){
                  widget.provider.searchInventoryName(value)
                },
                setState((){})
              }
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pop(context,false),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      padding: const EdgeInsets.only(top: 6,bottom: 6,left: 6,right: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: Colors.red,width: 0.5)
                      ),
                      child: const Center(child:Text('Close',style: TextStyle(color: Colors.red)))
                    )
                  )
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      if(textController.text.isNotEmpty && !widget.provider.isInventoryAvailable){
                        var value = await widget.provider.createInventory(textController.text);
                        if(value){
                          setState(() {});
                          showSnackbar(context,'Inventory Created');
                          Navigator.pop(context);
                        }else{
                          showSnackbar(context, 'Something went wrong');
                        }
                      }else{
                        showSnackbar(context,'Please Provider valid name');
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: const Center(child: Text('Create',style: TextStyle(color: Colors.white)))
                    )
                  ),
                )  
              ]
            )
          ]
        )
      )
    );
  }

  showSnackbar(BuildContext context,String message){
    var snackBar = SnackBar(content: Text(message,style: const TextStyle(fontSize: 12)),duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}