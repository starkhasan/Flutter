import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/provider/input_provider.dart';
import 'package:inventory_control/utils/close_button.dart';
import 'package:inventory_control/utils/preferences.dart';
import 'package:inventory_control/utils/product_content.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class InputPage extends StatefulWidget {
  const InputPage({ Key? key }) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InputProvider(),
      child: const MainInputScreen()
    );
  }
}

class MainInputScreen extends StatefulWidget {
  const MainInputScreen({ Key? key}) : super(key: key);

  @override
  _MainInputScreenState createState() => _MainInputScreenState();
}

class _MainInputScreenState extends State<MainInputScreen>{

  var productController = TextEditingController();
  var quantityController = TextEditingController();
  var descriptionConstroller = TextEditingController();
  var firebaseDataBaseReferene = FirebaseDatabase.instance.reference().child('inventory_control').child(Preferences.getUserId()).child(Preferences.getInventoryName());
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  scrollTop(){
    Timer(const Duration(milliseconds: 100),() => scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Input',style: TextStyle(fontSize: 14)),
      ),
      floatingActionButton: Consumer<InputProvider>(
        builder: (context,provider,child){
          return provider.showFabButton
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
            stream: firebaseDataBaseReferene.child('input').onValue,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }else if(snapshot.connectionState == ConnectionState.active && snapshot.data.snapshot.value != null){
                scrollTop();
                var input = snapshot.data.snapshot.value;
                return ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: input.length,
                  reverse: true,
                  itemBuilder: (BuildContext context,int index){
                    var key = input.keys.elementAt(index);
                    return ProductContent(input: input,keyInput: key);
                  }
                );
              }else{
                return const Center(child: Text('To add input click + button in bottom right corner'));
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => {
                              productController.clear(),
                              quantityController.clear(),
                              descriptionConstroller.clear(),
                              provider.fabVisibility(true)
                            },
                            child: const CloseButtonHelper()
                          ),
                        ),
                        TextField(
                          controller: productController,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'Product Id*',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10
                            )
                          )
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
                            var data = await provider.createInventory(context,productController.text,quantityController.text,descriptionConstroller.text);
                            if(data){
                              productController.clear();
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
