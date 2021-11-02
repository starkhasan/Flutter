import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/provider/input_provider.dart';
import 'package:inventory_control/utils/datetime_conversion.dart';
import 'package:inventory_control/utils/preferences.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class OutputPage extends StatefulWidget {
  const OutputPage({ Key? key }) : super(key: key);

  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InputProvider(),
      child: const MainOutputScreen(),
    );
  }
}

class MainOutputScreen extends StatefulWidget {
  const MainOutputScreen({ Key? key}) : super(key: key);

  @override
  _MainOutputScreenState createState() => _MainOutputScreenState();
}

class _MainOutputScreenState extends State<MainOutputScreen>{

  var productController = const TextEditingValue(text: '');
  var quantityController = TextEditingController();
  var descriptionConstroller = TextEditingController();
  var firebaseDataBaseReferene = FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId());
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<InputProvider>(context,listen: false);
      provider.getInventoryData('');
    });
  }

  scrollTop() {
    Timer(const Duration(milliseconds: 100), () => scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Output',style: TextStyle(fontSize: 14)),
      ),
      floatingActionButton: Consumer<InputProvider>(
        builder: (context,provider,child){
          return provider.showFabButton && provider.inventoryData.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => provider.fabVisibility(false),
              child: const Icon(Icons.add),
            )
          : const SizedBox();
        }
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: firebaseDataBaseReferene.child('output').onValue,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }else if(snapshot.connectionState == ConnectionState.active && snapshot.data.snapshot.value != null){
                scrollTop();
                var input = snapshot.data.snapshot.value;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: input.length,
                  reverse: true,
                  controller: scrollController,
                  itemBuilder: (BuildContext context,int index){
                    var key = input.keys.elementAt(index);
                    return Container(
                      margin: const EdgeInsets.only(top: 8,left: 5,right: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 1.0)]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Product Id',style: TextStyle(color: Colors.grey,fontSize: 11)),
                                    Text(input[key]['productID'],style: const TextStyle(color: Colors.black,fontSize: 12))
                                  ]
                                )
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('Quantity',style: TextStyle(color: Colors.grey,fontSize: 11)),
                                    Text(input[key]['quantity'],style: const TextStyle(color: Colors.black,fontSize: 12))
                                  ]
                                ),
                              )
                            ]
                          ),
                          Visibility(
                            visible: input[key]['productDescription'].isNotEmpty,
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Text('Product Description',style: TextStyle(color: Colors.grey,fontSize: 10)),
                                Text(input[key]['productDescription'],style: const TextStyle(color: Colors.black,fontSize: 11))
                              ]
                            )
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(Radius.circular(2))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Created At',style: TextStyle(color: Colors.grey[600],fontSize: 10)),
                                Text(input[key]['createdAt'].toString().convertTime,style: const TextStyle(color: Colors.black,fontSize: 10))
                              ]
                            ),
                          )
                        ]
                      )
                    );
                  }
                );
              }else{
                return const Center(
                  child: Text(
                    'Empty Output Inventory'
                  )
                );
              }
            }
          ),
          Consumer<InputProvider>(
            builder: (context,provider,child){
              return Align(
                alignment: Alignment.bottomCenter,
                child: Visibility(
                  visible: !provider.showFabButton,
                  child: Container(
                    padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Color(0xFFD6D6D6),blurRadius: 4.0,spreadRadius: 1.0,offset: Offset(1, 1))]
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Visibility(
                                visible: provider.showStock,
                                child: Text(
                                  provider.productQuantity > 0
                                  ? 'In Stock : ${provider.productQuantity.toString()}'
                                  : 'Out of Stock',
                                  style: TextStyle(color: provider.productQuantity > 0 ? Colors.green : Colors.red,fontSize: 10,fontWeight: FontWeight.bold)
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => {
                                quantityController.clear(),
                                descriptionConstroller.clear(),
                                provider.fabVisibility(true)
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.only(top: 7,bottom: 7,left: 7,right: 7),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEBEE),
                                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(color: Colors.red,width: 0.5)
                                ),
                                child: const Text('Close',style: TextStyle(color: Colors.red,fontSize: 10))
                              )
                            )
                          ]
                        ),
                        Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue){
                            return provider.productId.where((element) => element.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (value) => {
                            provider.onSelectAutoCompleteText(value),
                            productController = TextEditingValue(text: value)
                          },
                          optionsMaxHeight: MediaQuery.of(context).size.height * 0.15,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: quantityController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'Quantity*',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10
                            )
                          )
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: descriptionConstroller,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'Product Description (Optional)',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10
                            )
                          )
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () async {
                            var data = await provider.removeInventory(context,productController.text,quantityController.text,descriptionConstroller.text);
                            if(data){
                              quantityController.clear();
                              descriptionConstroller.clear();
                            }
                          },
                          child: const Text('Submit',style: TextStyle(fontSize: 12))
                        )
                      ]
                    )
                  )
                )
              );
            }
          )
        ]
      )
    );
  }
}