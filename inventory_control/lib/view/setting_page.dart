import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_control/provider/setting_provider.dart';
import 'package:inventory_control/utils/confirmation_dialog.dart';
import 'package:inventory_control/utils/datetime_conversion.dart';
import 'package:provider/provider.dart';
import 'package:inventory_control/utils/helper.dart';

class SettingPage extends StatelessWidget {

  const SettingPage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingProvider(),
      child: Consumer<SettingProvider>(
        builder: (context,settingProvider,child){
          return MainSettingPage(provider: settingProvider);
        }
      )
    );
  }
}

class MainSettingPage extends StatefulWidget {
  final SettingProvider provider;
  const MainSettingPage({ Key? key,required this.provider}) : super(key: key);
  @override
  _MainSettingPageState createState() => _MainSettingPageState();
}

class _MainSettingPageState extends State<MainSettingPage> with Helper{

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var _imageSize = 0.0;
  var _buttonSize = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { 
      widget.provider.getInventoryData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageSize = MediaQuery.of(context).size.height * 0.05;
    _buttonSize = MediaQuery.of(context).size.height * 0.04;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            title: Text('Settings'),
            snap: true,
            floating: true
          ),
          widget.provider.loading
          ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator(strokeWidth: 2.0)))
          : SliverList(delegate: SliverChildListDelegate([mainContent()]))
        ]
      )
    );
  }

  Widget mainContent(){
    var data = widget.provider.inventoryData;
    nameController.text = data.userName;
    emailController.text = data.email;
    nameController.selection = TextSelection.fromPosition(TextPosition(offset: nameController.text.length));
    return Container(
      padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.zero,
              height: _imageSize * 2,
              width: _imageSize * 2,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    backgroundImage: data.imagePath.isEmpty ? const NetworkImage('https://i.ibb.co/Tm8jmFY/add-1.png') : NetworkImage(data.imagePath),
                    radius: _imageSize
                  ),
                  Positioned(
                    right: 0,bottom: 0,
                    child: Container(
                      width: _buttonSize,
                      height: _buttonSize,
                      decoration: const BoxDecoration(color: Colors.blue,shape: BoxShape.circle),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async{
                            var source = await chooseImageSource();
                            widget.provider.uploadImageFile(context,source);
                          },
                          icon: const Icon(Icons.camera_alt_rounded,color: Colors.white,size: 20)
                        )
                      )
                    )
                  )
                ]
              )
            )
          ),
          const SizedBox(height: 10),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Username',
              labelText: 'Username'
            )
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(4))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Created At',style: TextStyle(color: Colors.grey[600],fontSize: 11)),
                const SizedBox(height: 5),
                TextField(
                  enabled: false,
                  controller: TextEditingController(text: data.createdAt.toString().convertTime),
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Created At'
                  ),
                )
              ]
            )
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(4))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Registered Email',style: TextStyle(color: Colors.grey[600],fontSize: 11)),
                const SizedBox(height: 5),
                TextField(
                  enabled: false,
                  controller: TextEditingController(text: data.email),
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Registered Email',
                  ),
                )
              ]
            )
          ),
          const SizedBox(height: 15),
          Visibility(visible: data.listInventory.isNotEmpty, child: const Text('Total Inventory',style: TextStyle(fontSize: 12.0))),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.listInventory.length,
            itemBuilder: (BuildContext context,int index){
              return InkWell(
                onTap: () => print('Click Here to Edit or Delete the Inventory'),
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5,right: 8),
                  margin: const EdgeInsets.only(top: 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            child: Center(child: Text(data.listInventory[index].substring(0,1).toUpperCase(),style: const TextStyle(color: Colors.black))),
                          ),
                          const SizedBox(width: 5),
                          Text(data.listInventory[index],style: const TextStyle(fontSize: 16.0)),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => print('Click Here to Edit the Inventory'),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                shape: BoxShape.circle
                              ),
                              child: const Icon(Icons.edit,size: 20,color: Colors.blue)
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => showLogoutDialog(data.listInventory[index]),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                shape: BoxShape.circle
                              ),
                              child: const Icon(Icons.delete,size: 20,color: Colors.red)
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ),
              );
            }
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => {
              FocusScope.of(context).unfocus(),
              widget.provider.changeName(context,nameController.text)
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.048,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: const Center(child: Text('Update',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
            ),
          )
        ]
      )
    );
  }

  showLogoutDialog(String inventoryName) {
    showDialog(
      context: context, 
      builder: (context){
        return ConfirmationDialog(
          title: 'Delete', 
          content: 'Are you sure you want to Delete $inventoryName?', 
          onPressed: () => widget.provider.deleteInventory(context, inventoryName)
        );
      }
    );
  }

  Future<ImageSource> chooseImageSource() async{
    var source = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: const Text('Choose Image Source',style: TextStyle(fontSize: 14)),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,ImageSource.camera),
              child: const Text('Camera',style: TextStyle(fontSize: 14))
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: const Text('Gallery',style: TextStyle(color: Colors.red,fontSize: 14))
            )
          ]
        );
      }
    );
    return source;
  }
}