import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/provider/setting_inventory_provider.dart';
import 'package:inventory_control/utils/datetime_conversion.dart';
import 'package:provider/provider.dart';


class SettingInventory extends StatelessWidget {
  final String name;
  const SettingInventory({ Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingInventoryProvider(),
      child: MainSettingInventory(inventoryName: name)
    );
  }
}

class MainSettingInventory extends StatefulWidget {
  final String inventoryName;
  const MainSettingInventory({ Key? key,required this.inventoryName}) : super(key: key);
  @override
  State<MainSettingInventory> createState() => _MainSettingInventoryState();
}

class _MainSettingInventoryState extends State<MainSettingInventory> {

  late TextEditingController inventoryNameCont;
  @override
  void initState() {
    super.initState();
    inventoryNameCont = TextEditingController(text: widget.inventoryName);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { 
      var provider = Provider.of<SettingInventoryProvider>(context,listen: false);
      provider.getInventoryData(context,widget.inventoryName);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            title: Text('Settings Inventory',style: TextStyle(fontSize: 14)),
            snap: true,
            floating: true
          ),
          Consumer<SettingInventoryProvider>(
            builder: (context,provider,child){
              return provider.loading
              ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator(strokeWidth: 2.0)))
              : SliverList(delegate: SliverChildListDelegate([mainContent(provider)]));
            }
          )
        ]
      )
    );
  }

  Widget mainContent(SettingInventoryProvider provider){
    var data = provider.settingInventoryData;
    return Container(
      padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: inventoryNameCont,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(
              isDense: true,
              hintText: 'Inventory Name',
              labelText: 'Inventory Name'
            )
          ),
          const SizedBox(height: 15),
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
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(4))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Input Entry',style: TextStyle(color: Colors.black,fontSize: 11)),
                    Text(data.inputEntry.toString(),style: const TextStyle(color: Colors.black,fontSize: 14)),
                  ]
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Output Entry',style: TextStyle(color: Colors.black,fontSize: 11)),
                    Text(data.outputEntry.toString(),style: const TextStyle(color: Colors.black,fontSize: 14)),
                  ]
                ),
                const SizedBox(height: 10),
                const Text('Inventory',style: TextStyle(color: Colors.black,fontSize: 11)),
                Container(
                  margin: const EdgeInsets.only(top: 5,left: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Product',style: TextStyle(color: Colors.grey[600],fontSize: 11)),
                          Text(data.totalProduct.toString(),style: const TextStyle(color: Colors.black,fontSize: 14)),
                        ]
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('InStock Product',style: TextStyle(color: Colors.grey[600],fontSize: 11)),
                          Text(data.inStockProduct.toString(),style: const TextStyle(color: Colors.green,fontSize: 14)),
                        ]
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Out of Stock Product',style: TextStyle(color: Colors.grey[600],fontSize: 11)),
                          Text(data.outStockProduct.toString(),style: const TextStyle(color: Colors.red,fontSize: 14)),
                        ]
                      )
                    ]
                  ),
                )
              ],
            )
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Enable'),
              CupertinoSwitch(
                value: data.enabled, 
                onChanged: (value) => provider.enabledInventory(context, widget.inventoryName, value)
              )
            ]
          ),
          const SizedBox(height: 20),
          InkWell(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(4))
              ),
              child: const Center(child: Text('Update',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white))),
            ),
          )
        ]
      )
    );
  }

}