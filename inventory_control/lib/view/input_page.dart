import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/provider/input_provider.dart';
import 'package:provider/provider.dart';

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
  var firebaseDataBaseReferene = FirebaseDatabase.instance.reference().child('inventory_control');

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
                var input = snapshot.data.snapshot.value;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: input.length,
                  reverse: true,
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
                                    const Text('Product Id',style: TextStyle(color: Colors.grey,fontSize: 10)),
                                    Text(input[key]['productID'],style: const TextStyle(color: Colors.black,fontSize: 12))
                                  ]
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('Quantity',style: TextStyle(color: Colors.grey,fontSize: 10)),
                                    Text(input[key]['quantity'],style: const TextStyle(color: Colors.black,fontSize: 11))
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
                                Text(input[key]['createdAt'],style: const TextStyle(color: Colors.black,fontSize: 10))
                              ]
                            ),
                          )
                        ]
                      )
                    );
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
                            onTap: () => provider.fabVisibility(true),
                            child: Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBEE),
                                borderRadius: const BorderRadius.all(Radius.circular(2)),
                                border: Border.all(color: Colors.red,width: 0.5)
                              ),
                              child: const Text('Close',style: TextStyle(color: Colors.red,fontSize: 10))
                            )
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
                          child: const Text('Create',style: TextStyle(fontSize: 12))
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