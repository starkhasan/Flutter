import 'package:flutter/material.dart';
import 'package:inventory_control/provider/setting_provider.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { 
      widget.provider.getInventoryData();
    });
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
          const Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('asset/app_icon.png')
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
          const Text('Total Inventory',style: TextStyle(fontSize: 12.0)),
          const SizedBox(height: 2),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.listInventory.length,
            itemBuilder: (BuildContext context,int index){
              return Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: const Color(0xFF424242),width: 0.5)
                ),
                child: Text(data.listInventory[index],style: const TextStyle(fontSize: 16.0))
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
}